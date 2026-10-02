#!/usr/bin/env python3
"""Lo que se ha MEDIDO del cartucho, clavado para que no se deshaga solo.

Estas comprobaciones necesitan la ROM, y si no esta **fallan**: no se saltan.
Un test que se salta no comprueba nada y en verde daria la impresion
contraria. Quien clone esto sin poner su copia del cartucho vera fallar este
fichero con un mensaje que dice exactamente que falta; los tests que solo
miran el listado publicado siguen pasando.

Cada una corresponde a una afirmacion de la web o de las notas, y todas leen
el binario: ninguna compara una constante contra si misma.
"""
import hashlib
import os
import sys
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))

from paginas import ORG, TAM_PAGINA, N_PAGINAS, EXCEPCIONES   # noqa: E402

ROM = os.path.join(RAIZ, "goemon.rom")
SHA = "a436addc241d977ba38081463322e7e611d6bab4d10cd06305fe5a71f02a549c"

FALTA = ("falta goemon.rom en la raiz del repo. Son los 131.072 bytes de "
         "Ganbare Goemon (Konami, RC-748, 1987, MSX2), y no se distribuyen "
         "aqui: pon tu copia. El sha256 tiene que ser %s" % SHA)


class Cartucho(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        if not os.path.exists(ROM):
            raise AssertionError(FALTA)
        with open(ROM, "rb") as f:
            cls.rom = f.read()

    def test_es_la_misma_rom(self):
        self.assertEqual(len(self.rom), 131072)
        self.assertEqual(hashlib.sha256(self.rom).hexdigest(), SHA)

    def test_cabecera_ab(self):
        """0x4000 'AB', INIT 0x4097 y los otros tres vectores a cero."""
        self.assertEqual(self.rom[0:2], b"AB")
        self.assertEqual(self.rom[2] | (self.rom[3] << 8), 0x4097)
        self.assertEqual(self.rom[4:10], b"\x00" * 6)

    def test_segunda_cabecera_del_game_master(self):
        """0x4010: 'CD', 0x07 y 0x48, o sea RC-748."""
        self.assertEqual(self.rom[0x10:0x14], b"CD\x07\x48")

    def test_es_msx2_pide_screen_5(self):
        """p00:4994 `ld a,5 / call 0x005F` (CHGMOD): SCREEN 5, que solo tiene un MSX2."""
        self.assertEqual(self.rom[0x0994:0x0999], bytes([0x3E, 0x05, 0xCD, 0x5F, 0x00]))

    def test_mapper_es_konami4(self):
        """Ni una escritura a los registros del mapper CON SCC."""
        for reg in (0x5000, 0x7000, 0x9000, 0xB000):
            pat = bytes([0x32, reg & 0xFF, reg >> 8])
            self.assertNotIn(pat, self.rom,
                             "aparece un ld (%#06x),a: seria Konami5" % reg)
        for reg in (0x6000, 0x8000, 0xA000):
            self.assertIn(bytes([0x32, reg & 0xFF, reg >> 8]), self.rom)

    def test_regla_banco_org(self):
        """Cada banco se mapea en su ranura, salvo la excepcion declarada.

        Se recorren los `ld a,N` seguidos de `ld (reg),a` -con los `inc a` y
        `ld (hl),a` / `inc l` / `inc hl` del reparto de tres en medio-: el
        banco que llega a cada registro tiene que ser de los que
        tools/paginas.py pone en esa ranura, o una EXCEPCION con su sitio.
        """
        regs = (0x6000, 0x8000, 0xA000)
        vistos = {}
        for i in range(len(self.rom) - 5):
            if self.rom[i] != 0x3E:                 # ld a,N
                continue
            j, val = i + 2, self.rom[i + 1]
            while j < len(self.rom) - 2:
                w = self.rom[j + 1] | (self.rom[j + 2] << 8)
                if self.rom[j] == 0x32 and w in regs:
                    if val < N_PAGINAS:
                        b = j // TAM_PAGINA
                        sitio = (b, ORG[b] + j % TAM_PAGINA)
                        vistos.setdefault(val, set()).add((w, sitio))
                    j += 3
                elif self.rom[j] == 0x3C:           # inc a
                    val += 1
                    j += 1
                elif self.rom[j] in (0x77, 0x2C, 0x23):  # ld (hl),a / inc l / inc hl
                    j += 1
                else:
                    break
        self.assertEqual(sorted(vistos), list(range(1, 16)))
        for banco, rs in sorted(vistos.items()):
            for reg, sitio in rs:
                if ORG[banco] != reg:
                    self.assertEqual(EXCEPCIONES.get((banco, sitio)), reg,
                                     "el banco %d va a %#06x en %s y paginas.py dice %#06x"
                                     % (banco, reg, sitio, ORG[banco]))

    def test_gancho_de_interrupcion(self):
        """INIT engancha 0x4045 en H.TIMI (0xFD9F/0xFDA0) y se queda en `jr $`."""
        pat = bytes([0x3E, 0xC3,                     # ld a,0xC3
                     0x32, 0x9F, 0xFD,               # ld (0xFD9F),a
                     0x21, 0x45, 0x40,               # ld hl,0x4045
                     0x22, 0xA0, 0xFD])              # ld (0xFDA0),hl
        self.assertEqual(self.rom[0x00D5:0x00D5 + len(pat)], pat)
        self.assertEqual(self.rom[0x00E5:0x00E7], b"\x18\xfe")   # jr $

    def test_la_interrupcion_llama_al_sonido_en_el_banco_10(self):
        """p00:404D pone los bancos 10, 11 y 12, llama a 0x6000 y devuelve las
        tres ranuras leyendo las copias 0xF0F1..0xF0F3."""
        esperado = bytes([0x3E, 0x0A, 0x32, 0x00, 0x60,  # ld a,10 / ld (0x6000),a
                          0x3C, 0x32, 0x00, 0x80,        # inc a / ld (0x8000),a
                          0x3C, 0x32, 0x00, 0xA0,        # inc a / ld (0xA000),a
                          0xCD, 0x00, 0x60,              # call 0x6000
                          0xF3,
                          0x3A, 0xF1, 0xF0, 0x32, 0x00, 0x60,
                          0x3A, 0xF2, 0xF0, 0x32, 0x00, 0x80,
                          0x3A, 0xF3, 0xF0, 0x32, 0x00, 0xA0])
        self.assertEqual(self.rom[0x004D:0x004D + len(esperado)], esperado)

    def test_no_hay_bancos_de_relleno(self):
        """Ningun banco es 0xFF de punta a punta."""
        for b in range(N_PAGINAS):
            blq = self.rom[b * TAM_PAGINA:(b + 1) * TAM_PAGINA]
            self.assertNotEqual(blq, b"\xff" * TAM_PAGINA)

    def test_despachador_de_konami(self):
        """El despachador esta en 0x408D: la tabla va detras del `call`.

        `pop hl / add a,a / call 0x4083 / ld e,(hl) / inc hl / ld d,(hl) /
        ex de,hl / jp (hl)`, y 0x4083 es `add a,l / ld l,a / ret nc / inc h /
        ret`.
        """
        self.assertEqual(self.rom[0x008D:0x0097],
                         bytes([0xE1, 0x87, 0xCD, 0x83, 0x40,
                                0x5E, 0x23, 0x56, 0xEB, 0xE9]))
        self.assertEqual(self.rom[0x0083:0x0088],
                         bytes([0x85, 0x6F, 0xD0, 0x24, 0xC9]))


if __name__ == "__main__":
    unittest.main()
