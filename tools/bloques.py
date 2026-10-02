#!/usr/bin/env python3
"""Declara los bloques de datos que el codigo LEE, recorriendolos como el cartucho.

Un rango de datos no se declara porque sobre: se declara porque hay una
instruccion que lo lee. Casi siempre es una llamada a uno de los lectores del
banco 0, y el trazador de cartucho entero (tools/bancos.py) sabe, para cada
llamada, que valen HL y DE y que bancos hay en cada ranura. Con eso:

  1. se coge el puntero que el lector va a leer;
  2. el banco al que cae sale del reparto de ese momento, no de suponerlo;
  3. el final sale de RECORRER el formato como lo recorre el lector, o de la
     cuenta que le pasa quien llama (B, BC), leida en el listado.

Los lectores del banco 0 (Ganbare Goemon es MSX2: SCREEN 5, 4 bits por pixel,
128 bytes por linea de VRAM):

  rle      0x4539  DE fuente, HL destino en la VRAM: 0x00 acaba; 0x80 trae
                   otro destino (dos bytes, 0x4533 los lee); 0x81-0xFF, van tal
                   cual los n&0x7F bytes que siguen; 0x01-0x7F, se repite el
                   byte que viene esas veces.
           0x4533  lo mismo, con el destino delante.
  espejo   0x4562  el mismo rle, pero a un bufer de RAM y con los bits del
                   byte dados la vuelta (dibujo mirando al otro lado).
  rle_ram  0x42C3  el mismo rle, de DE a la RAM de HL.
  dibujos  0x488E  HL fuente, B dibujos de 8x8 (4 filas de bytes x 8: 32 cada uno).
           0x48B8  HL fuente, B dibujos de 16x16 (128 bytes cada uno).
           0x4C75  como 0x488E, pero dados la vuelta (32 bytes cada uno).
  letras   0x484F  HL fuente, B caracteres de 8x8 a 1 bit (8 bytes cada uno).
  hmmc     0x4E7F  HL fuente, B ancho y C alto en pixeles: B*C/2 bytes que
                   el V9938 pinta con HMMC (0x47B2).
  paleta   0x4666  HL lista de [color][RB][G] (3 bytes); 0xFF acaba.
  rotulo   0x48F3  HL: [x][y] y caracteres; 0xFE trae otra posicion; 0xFF
                   acaba. 0x48F7 igual, en otro color; 0x48FD sin posicion.

Lo que sale se escribe, banco a banco, en una seccion delimitada de
src/pNN.notes que esta herramienta reescribe entera; lo de fuera no lo toca.
Un bloque que pise codigo trazado o una D escrita a mano NO se escribe: se
avisa, porque algo esta mal y hay que mirarlo.

Uso: bloques.py              informa de lo que encontraria
     bloques.py --escribe    y lo escribe en las notas
"""
import json
import os
import re
import sys
from collections import defaultdict

AQUI = os.path.dirname(os.path.abspath(__file__))
RAIZ = os.path.dirname(AQUI)
sys.path.insert(0, AQUI)

from bancos import traza_completa, Cartucho                  # noqa: E402
from paginas import ORG, TAM_PAGINA, N_PAGINAS, nombre        # noqa: E402

ROM = os.path.join(RAIZ, "goemon.rom")
SRC = os.path.join(RAIZ, "src")
WORK = os.path.join(RAIZ, "work")

INI = "# --- BLOQUES QUE LEE EL CODIGO (seccion que reescribe tools/bloques.py; no editar a mano) ---"
FIN = "# --- fin de los bloques de bloques.py ---"


class FueraDelBanco(Exception):
    pass


def banco_de(a, s):
    b = Cartucho.banco(a, s)
    if b is None or b >= N_PAGINAS:
        raise FueraDelBanco("0x%04X no cae en el cartucho con %s" % (a, s))
    return b


def byte(rom, s, a):
    return rom[banco_de(a, s) * TAM_PAGINA + (a & 0x1FFF)]


def palabra(rom, s, a):
    return byte(rom, s, a) | (byte(rom, s, a + 1) << 8)


def trozos(s, a, f):
    """[a, f) de la ventana del Z80, partido por bancos: [(banco, ini, fin)]."""
    fuera = []
    while a < f:
        corte = min(f, (a & 0xE000) + TAM_PAGINA)
        fuera.append((banco_de(a, s), a, corte))
        a = corte
    return fuera


# ------------------------------------------------------------------ registro
class Bloques:
    """{banco: {(ini, fin): {"nom", "que", "desde": set, "ancho"}}}"""

    def __init__(self):
        self.d = defaultdict(dict)
        self.avisos = []

    def anota(self, s, a, f, nom, que, quien, ancho=16):
        if a < 0xC000 < f:
            # p00:54E4: el ultimo dibujo se sale del cartucho y lo que falta
            # lo lee de la RAM de 0xC000 en adelante
            que += "; se sale de la ventana del cartucho: los ultimos %d bytes los lee "                    "de la RAM, de 0xC000 a 0x%04X" % (f - 0xC000, f - 1)
            f = 0xC000
        for b, i, j in trozos(s, a, f):
            e = self.d[b].setdefault((i, j), {"nom": nom if i == a else "%s_cola" % nom,
                                              "que": que, "desde": set(), "ancho": ancho})
            e["desde"].add(quien)
            if i != a:
                e["que"] = "%s (sigue del banco anterior, 0x%04X)" % (que, a)


# ------------------------------------------------------------------ listado
_LISTADO = {}


def listado(p):
    """[(dir, texto)] de las instrucciones del listado del banco p."""
    if p not in _LISTADO:
        ruta = os.path.join(SRC, "goemon_p%02d.asm" % p)
        filas = []
        for ln in open(ruta, encoding="utf-8"):
            m = re.match(r"\t([a-z][^\t;]*)\t+;([0-9a-f]{4})", ln)
            if m:
                filas.append((int(m.group(2), 16), m.group(1).strip()))
        _LISTADO[p] = filas
    return _LISTADO[p]


def num(txt):
    txt = txt.strip()
    if txt.endswith("h"):
        return int(txt[:-1], 16)
    return int(txt, 0)


def registro_antes(p, pc, reg, hasta=10):
    """El valor constante de B, C o BC cargado justo antes de pc, o None.

    Se miran hacia atras las instrucciones del listado; si alguna otra toca el
    registro antes de encontrar su `ld`, no se sabe.
    """
    filas = listado(p)
    idx = next((i for i, (a, _) in enumerate(filas) if a == pc), None)
    if idx is None:
        return None
    for a, t in reversed(filas[max(0, idx - hasta):idx]):
        if t.startswith(("call", "jp", "jr", "ret", "djnz")):
            return None
        m = re.match(r"ld (bc|b|c),([0-9a-f]+h|\d+)$", t)
        if m:
            r, v = m.group(1), num(m.group(2))
            if r == reg:
                return v
            if r == "bc":
                return {"b": v >> 8, "c": v & 0xFF}.get(reg)
            continue
        if re.match(r"(ld|inc|dec|pop|ex|exx|add|sub|and|or|xor)\b.*\b%s\b" % reg[0], t) and reg != "bc":
            if re.match(r"ld [^,]+,%s$" % reg, t):
                continue            # solo lo lee
            return None
    return None


def tabla_antes(p, pc):
    """Si pc lee su puntero de una tabla indexada, la base de esa tabla.

    El patron es el de siempre en este cartucho: `ld hl,TABLA / call 0x4061
    (hl += a) / ld e,(hl) / inc hl / ld d,(hl)` y, a lo sumo, un `ld hl,nn`
    o `ex de,hl` antes del lector.
    """
    filas = listado(p)
    idx = next((i for i, (a, _) in enumerate(filas) if a == pc), None)
    if idx is None:
        return None
    txt = [t for _, t in filas[max(0, idx - 8):idx]]
    for k in range(len(txt)):
        m = re.match(r"ld hl,([0-9a-f]+h)$", txt[k])
        if not m:
            continue
        # entre el `ld hl` y el `call 0x4061` puede ir el calculo del indice
        # (`ld a,(0xD000) / add a,a`), que no toca HL
        for j in range(k + 1, min(k + 4, len(txt) - 3)):
            if txt[j] in ("call L_4061", "call 04061h", "call hl_mas_a"):
                if txt[j + 1] == "ld e,(hl)" and txt[j + 2] == "inc hl" and txt[j + 3] == "ld d,(hl)":
                    return num(m.group(1))
                break
            if "hl" in txt[j] or txt[j].startswith(("call", "jp", "jr")):
                break
    return None


def punteros_de_tabla(rom, s, base, limite=None):
    """Las palabras de una tabla de punteros: hasta el primer destino, hasta una
    palabra que no apunte a la ventana del cartucho, o hasta `limite`."""
    ptrs, a = [], base
    tope = limite or base + 512
    while a < tope:
        w = palabra(rom, s, a)
        if not 0x4000 <= w < 0xC000:
            break
        ptrs.append(w)
        a += 2
        if base < min(ptrs) <= a + 1:
            break
        tope = min(tope, min(p for p in ptrs if p > base) if any(p > base for p in ptrs) else tope)
    return ptrs


# ------------------------------------------------------------------ formatos
def fin_rle(rom, s, a, con_destino):
    """Recorre un rle como 0x46EB/0x46F1 y devuelve el primer byte de fuera."""
    if con_destino:
        a += 2
    for _ in range(20000):
        n = byte(rom, s, a)
        a += 1
        if n == 0:
            return a
        if n & 0x80:
            k = n & 0x7F
            a += 2 if k == 0 else k
        else:
            a += 1
    raise FueraDelBanco("rle sin fin desde 0x%04X" % a)


def fin_filas(rom, s, a):
    """0x582D: 32 filas; cada una un byte n (ceros por la izquierda) y 12 - n
    bytes de dibujo. Rellena con ceros hasta 16 por fila en 0xE800."""
    for _ in range(32):
        n = byte(rom, s, a)
        if n > 12:
            raise FueraDelBanco("fila con %d ceros en 0x%04X" % (n, a))
        a += 1 + 12 - n
    return a



# ------------------------------------------------------------------ formatos
def fin_rle(rom, s, a, con_destino):
    """Recorre un rle como 0x4539 / 0x42C3 y devuelve el primer byte de fuera."""
    if con_destino:
        a += 2
    for _ in range(40000):
        n = byte(rom, s, a)
        a += 1
        if n == 0:
            return a
        if n & 0x80:
            k = n & 0x7F
            a += 2 if k == 0 else k
        else:
            a += 1
    raise FueraDelBanco("rle sin fin desde 0x%04X" % a)


def fin_lista(rom, s, a, paso):
    """Lista de registros de `paso` bytes que acaba en un 0xFF."""
    for _ in range(2000):
        if byte(rom, s, a) == 0xFF:
            return a + 1
        a += paso
    raise FueraDelBanco("lista sin 0xFF desde 0x%04X" % a)


def fin_rotulo(rom, s, a, con_posicion=True):
    """0x48F3: [x][y] y caracteres; 0xFE trae otra posicion; 0xFF acaba."""
    if con_posicion:
        a += 2
    for _ in range(4000):
        c = byte(rom, s, a)
        a += 1
        if c == 0xFF:
            return a
        if c == 0xFE:
            a += 2
    raise FueraDelBanco("rotulo sin 0xFF desde 0x%04X" % a)


def _n(v):
    return 256 if v == 0 else v


# lector -> (registro de la fuente, como se mide, nombre, que)
LECTORES = {
    0x4539: ("de", "rle", "rle", "rle a la VRAM (0x4539)"),
    0x4533: ("de", "rle+", "rle", "rle a la VRAM con el destino delante (0x4533)"),
    0x4562: ("de", "rle", "rle_espejo", "rle dado la vuelta a un bufer y de ahi a la VRAM (0x4562)"),
    0x455C: ("de", "rle+", "rle_espejo", "rle dado la vuelta, con el destino delante (0x455C)"),
    0x42C3: ("de", "rle", "rle_ram", "rle a la RAM (0x42C3)"),
    0x488E: ("hl", "b*32", "dibujos", "dibujos de 8x8 a 4 bits, 32 bytes cada uno (0x488E)"),
    0x4879: ("hl", "32", "dibujo", "un dibujo de 8x8 a 4 bits (0x4879)"),
    0x48B8: ("hl", "b*128", "dibujos16", "dibujos de 16x16 a 4 bits, 128 bytes cada uno (0x48B8)"),
    0x48A3: ("hl", "128", "dibujo16", "un dibujo de 16x16 a 4 bits (0x48A3)"),
    0x4C75: ("hl", "b*32", "dibujos_vuelta", "dibujos de 8x8 que 0x4C75 da la vuelta, 32 bytes cada uno"),
    0x484F: ("hl", "b*8", "letras", "caracteres de 8x8 a 1 bit, 8 bytes cada uno (0x484F)"),
    0x4858: ("hl", "8", "letra", "un caracter de 8x8 a 1 bit (0x4858)"),
    0x4E7F: ("hl", "bc/2", "hmmc", "dibujo que el V9938 pinta con HMMC (0x4E7F): ancho x alto / 2 bytes"),
    0x47B2: ("hl", "bc/2", "hmmc", "dibujo que el V9938 pinta con HMMC (0x47B2): ancho x alto / 2 bytes"),
    0x4666: ("hl", "lista3", "paleta", "colores de la paleta, [color][RB][G], 0xFF acaba (0x4666)"),
    0x48F3: ("hl", "rotulo", "rotulo", "rotulo: [x][y] y caracteres, 0xFE otra posicion, 0xFF acaba (0x48F3)"),
    0x48F7: ("hl", "rotulo", "rotulo", "rotulo en el otro color (0x48F7)"),
    0x48FD: ("hl", "rotulo-", "rotulo", "rotulo sin posicion delante (0x48FD)"),
}


def llamadas_a_lectores(rom, t, bl):
    vistos = set()
    for dest, b, pc, s, hl, de in t.llamadas:
        if dest not in LECTORES:
            continue
        reg, como, nom, que = LECTORES[dest]
        a = hl if reg == "hl" else de
        if a is None or not 0x4000 <= a < 0xC000:
            continue
        clave = (dest, b, pc, s, a)
        if clave in vistos:
            continue
        vistos.add(clave)
        quien = "%s:%04X" % (nombre(b), pc)
        if como == "rle":
            f = fin_rle(rom, s, a, False)
        elif como == "rle+":
            f = fin_rle(rom, s, a, True)
        elif como == "lista3":
            f = fin_lista(rom, s, a, 3)
        elif como == "rotulo":
            f = fin_rotulo(rom, s, a)
        elif como == "rotulo-":
            f = fin_rotulo(rom, s, a, False)
        elif como.startswith("b*"):
            n = registro_antes(b, pc, "b")
            if n is None:
                bl.avisos.append("%s: no se sabe B para 0x%04X (%04X)" % (quien, dest, a))
                continue
            f = a + _n(n) * int(como[2:])
        elif como == "bc/2":
            w = registro_antes(b, pc, "bc")
            if w is None:
                bl.avisos.append("%s: no se sabe BC para 0x%04X (%04X)" % (quien, dest, a))
                continue
            f = a + _n(w >> 8) * _n(w & 0xFF) // 2
        else:
            f = a + int(como)
        bl.anota(s, a, f, "%s_%04X" % (nom, a), que, quien)



# ------------------------------------------------------------------ el mapa
# Una pantalla son 8x6 bloques de 4x4 caracteres (8x8 la del estado 0x0B).
# p00:4295 descomprime TODAS las pantallas del juego de graficos (0xC289) en
# 0xD000, 48 bytes cada una; p00:42AC descomprime sus bloques en 0xE100, 16
# bytes cada uno; p00:5311 copia en 0xE700 la rejilla de pantallas de la zona
# (0xC288 fase x 7 + 0xC280 zona); p00:5275 monta la pantalla en 0xD800.
FASES, ZONAS = 7, 7
S13 = (13, 14, 15)          # p00:4268


def juego_de_cada_zona(rom):
    """0xC289 de cada zona: p01:6644 lo lee en la tabla 0xB8EC del banco 9."""
    o = 9 * TAM_PAGINA + (0xB8EC - 0xA000)
    return list(rom[o:o + FASES * ZONAS])


def casillas(rom, k):
    """Las casillas de la zona k: el primer byte de su ficha de enlaces, en la
    tabla 0xB7D0 del banco 6 (p00:418E)."""
    a = palabra(rom, S4, 0xB7D0 + 2 * k)
    return byte(rom, S4, a)


S4 = (4, 5, 6)              # p00:4220
S1 = (1, 2, 3)              # p00:4206
S12 = (10, 11, 12)          # p00:4250


def mapas(rom, t, bl):
    s = S13
    # las pantallas comprimidas de cada juego de graficos
    bl.anota(s, 0x6000, 0x600C, "pantallas_de_cada_juego",
             "6 punteros, uno por juego de graficos (0xC289): las pantallas de ese juego, en rle; "
             "p00:4295 las descomprime en 0xD000 (48 bytes cada una)", "p00:429C")
    for k in range(6):
        a = palabra(rom, s, 0x6000 + 2 * k)
        bl.anota(s, a, fin_rle(rom, s, a, False), "pantallas_%d" % k,
                 "las pantallas del juego de graficos %d en rle (0x42C3 las deja en 0xD000): "
                 "8x6 bloques cada una" % k, "p00:42A6")
    # la rejilla de cada zona: tantas casillas como dice su tabla de enlaces
    # (0xB7D0); medio byte por casilla en los juegos 0-3, uno en el 4 y el 5
    juego = juego_de_cada_zona(rom)
    bl.anota(s, 0x600C, 0x600C + 2 * FASES * ZONAS, "rejilla_de_cada_zona",
             "49 punteros, uno por zona (fase x 7 + zona): la rejilla de pantallas que p00:5311 "
             "copia en 0xE700", "p00:5317")
    for k in range(FASES * ZONAS):
        a = palabra(rom, s, 0x600C + 2 * k)
        n = casillas(rom, k)
        largo = (n + 1) // 2 if juego[k] < 4 else n
        bl.anota(s, a, a + largo, "rejilla_%04X" % a,
                 "rejilla de pantallas de una zona: %d casillas, %s (p00:5311 copia siempre %s, "
                 "y lo de mas es de la zona de al lado); varias zonas la comparten"
                 % (n, "medio byte cada una" if juego[k] < 4 else "un byte cada una",
                    "64 bytes" if juego[k] < 4 else "128 bytes"),
                 "zona %d-%d" % (k // ZONAS + 1, k % ZONAS))
    # los bloques de cada juego
    bl.anota(s, 0x75B9, 0x75C5, "bloques_de_cada_juego",
             "6 punteros, uno por juego de graficos: los bloques de 4x4 caracteres en rle; "
             "p00:42AC los descomprime en 0xE100 (16 bytes cada uno)", "p00:42B3")
    for k in range(6):
        a = palabra(rom, s, 0x75B9 + 2 * k)
        bl.anota(s, a, fin_rle(rom, s, a, False), "bloques_%d" % k,
                 "los bloques de 4x4 caracteres del juego de graficos %d, en rle" % k, "p00:42BD")
    # las pantallas sueltas, con sus bloques sin comprimir
    for pant, filas, blq, quien, que in (
            (0x7239, 6, 0x7269, "p00:525D", "la pantalla de la demo (0xC482)"),
            (0x7419, 6, 0x7449, "p00:5268", "la pantalla de la casilla 0xFF de la rejilla"),
            (0x7549, 6, 0x8EDD, "p00:526D", "la pantalla del estado 8"),
            (0x7581, 8, 0x8F9D, "p00:5272", "la pantalla del estado 0x0B (8 filas de bloques)")):
        n = 8 * filas
        bl.anota(s, pant, pant + n, "pantalla_%04X" % pant,
                 "%s: %d bloques de 4x4 caracteres, sin comprimir" % (que, n), quien)
        maxi = max(rom[Cartucho.banco(pant, s) * TAM_PAGINA + ((pant + i) & 0x1FFF)] for i in range(n))
        bl.anota(s, blq, blq + 16 * (maxi + 1), "bloques_%04X" % blq,
                 "los %d bloques que usa %s, 16 bytes cada uno (p00:52A6..52B5)" % (maxi + 1, que), quien)


# ------------------------------------------------------------------ el sonido
# El controlador del banco 10 (0x6000, con 10-11-12 puestos) lee, por canal,
# una partitura que interpreta p10:61F1:
#   0x00-0xBF  nota: nibble alto la nota, nibble bajo la duracion   1 byte
#   0xC0-0xCF  silencio de esa duracion (p10:631B)                  1
#   0xD0-0xDF  la unidad de tiempo (p10:63A1)                       1
#   0xE0-0xE5  la octava (p10:63F6)                                 1
#   0xE8, 0xEC un byte detras (p10:63E3, p10:63D7)                  2
#   0xEA       salta a la direccion que sigue (p10:6416)            3, y no sigue
#   0xED       llama a la direccion que sigue (p10:641D)            3
#   0xEE       vuelve de la llamada (p10:642B)                      1, y no sigue
#   resto 0xEx una bandera (p10:6400, 6408, 640F, 63EF)             1
#   0xFF       el canal acaba (p10:6434)                            1, y no sigue
#   0xFE n dir repite n veces desde dir (p10:635A)                  4
#   resto 0xFx el volumen y su envolvente en el byte de detras       2
S10 = (10, 11, 12)          # p00:4FE9..5002


def recorre_partitura(rom, s, a, tocados, pendientes):
    for _ in range(20000):
        c = byte(rom, s, a)
        tocados.add(a)
        if c < 0xD0:
            a += 1
        elif c < 0xE0:
            a += 1
        elif c < 0xF0:
            k = c & 0x0F
            if k in (0x8, 0xC):
                tocados.add(a + 1)
                a += 2
            elif k == 0xA:
                tocados.update((a + 1, a + 2))
                pendientes.append(palabra(rom, s, a + 1))
                return
            elif k == 0xD:
                tocados.update((a + 1, a + 2))
                pendientes.append(palabra(rom, s, a + 1))
                a += 3
            elif k == 0xE:
                return
            else:
                a += 1
        else:
            k = c & 0x0F
            if k == 0xF:
                return
            if k == 0xE:
                tocados.update((a + 1, a + 2, a + 3))
                pendientes.append(palabra(rom, s, a + 2))
                a += 4
            else:
                tocados.add(a + 1)
                a += 2
    raise FueraDelBanco("partitura sin fin desde 0x%04X" % a)


# Los efectos van por otro interprete, p10:6454, que lee un cuadro cada vez:
#   0xFF       acaba (p10:6550)                                    1, y no sigue
#   0xFE n dir repite n veces desde dir (p10:64D5)                  4
#   0x1x       ruido (x*2 al registro 6) y luego volumen/tono      3
#   0x2x d     mezcla del canal y d cuadros; 0x28-0x2F traen dos
#              bytes mas, la envolvente (p10:64F5)                 2 o 4
#   el resto   nibble alto el volumen, bajo y el byte de detras el
#              tono                                                2
def recorre_efecto(rom, s, a, tocados, pendientes):
    for _ in range(20000):
        c = byte(rom, s, a)
        tocados.add(a)
        if c == 0xFF:
            return
        if c == 0xFE:
            tocados.update((a + 1, a + 2, a + 3))
            pendientes.append(palabra(rom, s, a + 2))
            a += 4
        elif c & 0xF0 == 0x10:
            tocados.update((a + 1, a + 2))
            a += 3
        elif c & 0xF0 == 0x20:
            n = 4 if c >= 0x28 else 2
            tocados.update(range(a + 1, a + n))
            a += n
        else:
            tocados.add(a + 1)
            a += 2
    raise FueraDelBanco("efecto sin fin desde 0x%04X" % a)


def partituras(rom, s, inicios, recorre=recorre_partitura):
    """Todos los bytes que alcanza el interprete desde esos inicios."""
    tocados, pend, vistos = set(), list(inicios), set()
    while pend:
        a = pend.pop()
        if a in vistos:
            continue
        vistos.add(a)
        recorre(rom, s, a, tocados, pend)
    return tocados


def tramos(dirs):
    """Rangos [a, f) seguidos de un conjunto de direcciones."""
    fuera = []
    for x in sorted(dirs):
        if fuera and x == fuera[-1][1]:
            fuera[-1][1] = x + 1
        else:
            fuera.append([x, x + 1])
    return fuera


N_MUSICAS = 0x1C             # 0x80..0x9B: p00:505C, seis bytes cada una
N_EFECTOS = 0x21             # 0x00..0x20: p00:50DF, una palabra cada uno (el 0 no se lee)


def sonido(rom, t, bl):
    s = S10
    bl.anota(s, 0x6552, 0x6550 + 2 * N_EFECTOS, "efectos_de_sonido",
             "32 punteros, los de los efectos 0x01-0x20 (p00:50DF suma el doble del numero a "
             "0x6550: la palabra del 0 serian los bytes 37 C9 de `scf / ret` de p10:6550, y no se "
             "lee porque p00:5009 para el sonido con el 0): la lista de cuadros del canal de "
             "efectos que p00:50E7 deja en 0xC074", "p00:50DF")
    bl.anota(s, 0x6592, 0x6592 + 6 * N_MUSICAS, "musicas",
             "28 musicas (0x80-0x9B) de tres punteros cada una, la partitura de cada canal del "
             "PSG, que p00:5064 deja en 0xC01A, 0xC034 y 0xC04E", "p00:505C")
    efectos = [palabra(rom, s, 0x6550 + 2 * k) for k in range(1, N_EFECTOS)]
    for a, f in tramos(partituras(rom, s, efectos, recorre_efecto)):
        bl.anota(s, a, f, "efecto_%04X" % a,
                 "cuadros de un efecto de sonido que interpreta p10:6454 (volumen y tono, ruido, "
                 "mezcla y repeticiones; ver tools/bloques.py)", "p10:6454")
    # los instrumentos: p10:628F escoge por (ix+8) una de nueve tablas de 13
    # punteros (uno por nota, p10:62C7) a una envolvente con el formato de los
    # efectos, que p10:6454 recorre cuadro a cuadro
    bl.anota(s, 0x8051, 0x8051 + 9 * 26, "instrumentos",
             "9 instrumentos (0xE8 n de la partitura, p10:628F), cada uno 13 punteros, uno por "
             "nota (p10:62C7), a la envolvente que p10:6454 recorre cuadro a cuadro", "p10:628F")
    envolventes = [palabra(rom, s, 0x8051 + 2 * k) for k in range(9 * 13)]
    for a, f in tramos(partituras(rom, s, envolventes, recorre_efecto)):
        bl.anota(s, a, f, "envolvente_%04X" % a,
                 "envolvente de un instrumento: cuadros de volumen como los de los efectos, que "
                 "p10:6454 recorre (ver tools/bloques.py)", "p10:62D2")
    musica = [palabra(rom, s, 0x6592 + 2 * k) for k in range(N_MUSICAS * 3)] + [0x6B74]
    for a, f in tramos(partituras(rom, s, musica)):
        bl.anota(s, a, f, "partitura_%04X" % a,
                 "partitura que interpreta p10:61F1 (nota, silencio, tiempo, octava, saltos, "
                 "llamadas y repeticiones; ver tools/bloques.py)", "p10:61F1")

# ------------------------------------------------------------------ las figuras
# p00:5B6D escoge el conjunto de figuras de la casilla (medio byte en la
# tabla 0x9BF0 del banco 14, una por zona); 0x5BB2[juego][conjunto] da la
# lista [n][n+1 tipos] y p00:5413 sube a la VRAM el dibujo de cada tipo con
# su ficha de 10 bytes de 0xA830 (banco 12).
N_TIPOS = 0x24


def figuras(rom, t, bl):
    juego = juego_de_cada_zona(rom)
    bl.anota(S13, 0x9BF0, 0x9BF0 + 2 * FASES * ZONAS, "figuras_de_cada_zona",
             "49 punteros, uno por zona: el conjunto de figuras de cada casilla (p00:5B6D)", "p00:5B70")
    usados = defaultdict(set)
    for k in range(FASES * ZONAS):
        a = palabra(rom, S13, 0x9BF0 + 2 * k)
        n = casillas(rom, k)
        for c in range(n):
            b = byte(rom, S13, a + c // 2)
            usados[juego[k]].add(b >> 4 if c % 2 == 0 else b & 0x0F)
        bl.anota(S13, a, a + (n + 1) // 2, "figuras_%04X" % a,
                 "el conjunto de figuras de cada una de las %d casillas de la zona, medio byte "
                 "cada una (nibble alto la par); varias zonas la comparten" % n,
                 "zona %d-%d" % (k // ZONAS + 1, k % ZONAS))
    bl.anota(S1, 0x5BB2, 0x5BBE, "conjuntos_de_cada_juego",
             "6 punteros, uno por juego de graficos (0xC289), a sus conjuntos de figuras (p00:5BA8)",
             "p00:5BA8")
    listas = set()
    for j in range(6):
        tab = palabra(rom, S1, 0x5BB2 + 2 * j)
        n = max(usados[j]) + 1
        bl.anota(S1, tab, tab + 2 * n, "conjuntos_juego_%d" % j,
                 "%d punteros, uno por conjunto de figuras del juego %d, a su lista (p00:5BAF)" % (n, j),
                 "p00:5BAF")
        for c in range(n):
            listas.add(palabra(rom, S1, tab + 2 * c))
    tipos = set()
    for a in sorted(listas):
        n = byte(rom, S1, a)
        tipos.update(byte(rom, S1, a + 1 + i) for i in range(n + 1))
        bl.anota(S1, a, a + 2 + n, "figuras_%04X" % a,
                 "un conjunto de figuras: [n] y n+1 tipos (0 es ninguno) que p00:5413 sube a la VRAM",
                 "p00:5416")
    bl.anota(S1, 0x54B8, 0x54E2, "jefe_de_cada_fase",
             "21 punteros (p00:5409, el numero lo da p02:9282) a la figura del jefe: un solo tipo",
             "p00:540C")
    for a in range(0x54E2, 0x54E6):
        tipos.add(byte(rom, S1, a))
    bl.anota(S1, 0x54E2, 0x54E6, "jefes",
             "los cuatro tipos a los que apunta 0x54B8: 0x22, 0x23, 0x24 y 0 (ninguno)", "p00:542F")
    bl.anota(S12, 0xA830, 0xA830 + 10 * N_TIPOS, "fichas_de_figura",
             "36 fichas de 10 bytes, una por tipo de figura 1-0x24 (p00:5465): el dibujo en rle, "
             "su sitio en la VRAM, los colores 4 y 6 de la paleta (0xFFFF, sin tocar) y el sitio "
             "de la copia dada la vuelta (0xFF, sin copia)", "p00:5465")
    for k in range(N_TIPOS):
        f = 0xA830 + 10 * k
        src = palabra(rom, S12, f)
        bl.anota(S12, src, fin_rle(rom, S12, src, False), "figura_%02X" % (k + 1),
                 "el dibujo de la figura de tipo 0x%02X en rle (p00:547C; p00:54AB lo vuelve a "
                 "leer dado la vuelta si la ficha lo pide)" % (k + 1), "p00:547C")
    bl.anota(S12, 0xA998, 0xA9C0, "dibujos_de_mas",
             "8 fichas de 5 bytes: [tipo][rle][VRAM], un dibujo de mas para los tipos 2, 3, 0x0A, "
             "0x0B, 0x0C, 0x0F, 0x15 y 0x1F (p00:5436)", "p00:5436")
    for k in range(8):
        src = palabra(rom, S12, 0xA998 + 5 * k + 1)
        bl.anota(S12, src, fin_rle(rom, S12, src, False), "de_mas_%04X" % src,
                 "dibujo de mas de la figura de tipo 0x%02X, en rle (p00:5454)"
                 % byte(rom, S12, 0xA998 + 5 * k), "p00:5454")


# ------------------------------------------------------------------ los caracteres
S7 = (7, 8, 9)              # p00:4238


def caracteres(rom, t, bl):
    """p00:4A96: los caracteres de cada juego de graficos, en rle en los bancos
    4 y 5, que 0x42C3 deja en 0xD000 y luego se suben a la VRAM."""
    bl.anota(S1, 0x4C4B, 0x4C57, "caracteres_de_cada_juego",
             "6 punteros, uno por juego de graficos (0xC289), a sus caracteres de 8x8 en rle; "
             "p00:4AA7 los descomprime en 0xD000 (con los bancos 4-5-6)", "p00:4A9D")
    for k in range(6):
        a = palabra(rom, S1, 0x4C4B + 2 * k)
        bl.anota(S4, a, fin_rle(rom, S4, a, False), "caracteres_%d" % k,
                 "los caracteres de 8x8 a 4 bits del juego de graficos %d, en rle (p00:4AA7 los "
                 "deja en 0xD000 y p00:4ABA los sube a la VRAM)" % k, "p00:4AA7")
    bl.anota(S1, 0x4C57, 0x4C75, "caracteres_vueltos_de_cada_juego",
             "6 fichas de 5 bytes, una por juego de graficos: [VRAM][n][fuente en 0xD000] de los "
             "caracteres que p00:4AC7 sube dados la vuelta (0x4C75); los juegos 2 y 3 van a cero", "p00:4C15")
    # el otro camino de p00:4BE1: el jugador 1 lee 0x9810 y el 2 0x9DF6 (bit 7 de 0xC002)
    bl.anota(S7, 0x9810, fin_rle(rom, S7, 0x9810, False), "rle_9810",
             "rle a la VRAM (0x4539) para el jugador 1; el del 2 es 0x9DF6 (p00:4BE1-4BEA)", "p00:4BED")


# ------------------------------------------------------------------ tablas de los bancos 6 y 9
def lista_de_paletas(rom, s, a, bl, nom, que, quien):
    f = fin_lista(rom, s, a, 3)
    bl.anota(s, a, f, nom, que, quien)


def paletas_y_planos(rom, t, bl):
    # la paleta de cada juego de graficos (p00:4CE6)
    bl.anota(S7, 0xA37A, 0xA386, "paleta_de_cada_juego",
             "6 punteros, uno por juego de graficos (0xC289), a su lista de colores (p00:4CF0)", "p00:4CE9")
    for k in range(6):
        a = palabra(rom, S7, 0xA37A + 2 * k)
        lista_de_paletas(rom, S7, a, bl, "paleta_juego_%d" % k,
                         "los colores del juego de graficos %d: [color][RB][G], 0xFF acaba (0x4666)" % k,
                         "p00:4CF3")
    # los colores de cada sitio (0xC267) en cada juego (p00:4D2C)
    bl.anota(S7, 0xA4C5, 0xA4D1, "colores_de_cada_sitio",
             "6 punteros, uno por juego de graficos, a una ventana de la lista de 0xA4D1: el "
             "puntero de cada sitio (0xC267) a los colores que se le cambian (p00:4D36)", "p00:4D33")
    bl.anota(S7, 0xA4D1, 0xA4F1, "colores_de_los_sitios",
             "16 punteros seguidos a listas de colores; cada juego entra por un sitio distinto "
             "(0xA4C5) y p00:4D3D escoge por 0xC267", "p00:4D3D")
    for k in range(16):
        a = palabra(rom, S7, 0xA4D1 + 2 * k)
        lista_de_paletas(rom, S7, a, bl, "colores_%04X" % a,
                         "colores de un sitio: [color][RB][G], 0xFF acaba (0x4666); 0xA4F4 es el "
                         "0xFF de la de 0xA4F1, una lista vacia", "p00:4D42")
    # el plano de cada zona (p00:59A9)
    bl.anota(S7, 0xA575, 0xA575 + 2 * FASES * ZONAS, "plano_de_cada_zona",
             "49 punteros, uno por zona (fase x 7 + zona), a su ficha de plano (p00:59B9)", "p00:59B6")
    for k in range(FASES * ZONAS):
        a = palabra(rom, S7, 0xA575 + 2 * k)
        f = a + 1
        while byte(rom, S7, f):
            f += 2
        bl.anota(S7, a, f + 1, "plano_%04X" % a,
                 "ficha de plano de una zona: el dibujo (0xA86D) y parejas [valor<<5 | x][y] que "
                 "p00:5A10 marca en 0xD800; 0 acaba", "zona %d-%d" % (k // ZONAS + 1, k % ZONAS))
    bl.anota(S7, 0xA86D, 0xA88D, "dibujos_de_plano",
             "16 punteros a los dibujos de plano (p00:59C2)", "p00:59BF")
    for k in range(16):
        a = palabra(rom, S7, 0xA86D + 2 * k)
        filas, ancho = byte(rom, S7, a), byte(rom, S7, a + 1)
        bl.anota(S7, a, a + 2 + filas * ((ancho + 7) // 8), "plano_dibujo_%d" % k,
                 "dibujo de plano %d: [filas][ancho] y un bit por casilla (p00:59D7 los pasa a "
                 "0xD800, 28 por fila)" % k, "p00:59C5")
    # el teclado de las contrasenas (p01:6CFB)
    bl.anota(S4, 0xADEC, 0xAE34, "teclado",
             "lo que da cada tecla al escribir la contrasena: 9 filas de la matriz x 8 bits "
             "(p01:6D08); con 0xFCAD a cero", "p01:6D00")
    bl.anota(S4, 0xAE34, 0xAE7C, "teclado_kana",
             "lo mismo con 0xFCAD distinto de cero (p01:6D05); 0x5B pasa a 0x5C sin la tecla de "
             "la fila 6 bit 0 (p01:6D1D)", "p01:6D05")
    # la pantalla de p00:5A93
    bl.anota(S4, 0xB6B2, 0xB6B2 + 12 * 20, "pantalla_B6B2",
             "12 filas de 20 caracteres que p00:5AA4 pinta desde (0x30, 0x20)", "p00:5A9F")
    bl.anota(S4, 0xB7A2, 0xB7A2 + 23 * 2, "sprites_B7A2",
             "23 sprites: [y][x] de cada uno; p00:5AC4 los copia a 0xEE00 con el dibujo 4 x n", "p00:5ABB")
    # los enlaces entre casillas de cada zona (p00:4188)
    bl.anota(S4, 0xB7D0, 0xB7D0 + 2 * FASES * ZONAS, "enlaces_de_cada_zona",
             "49 punteros, uno por zona, a su ficha de enlaces (p00:4191)", "p00:418E")
    for k in range(FASES * ZONAS):
        a = palabra(rom, S4, 0xB7D0 + 2 * k)
        m = byte(rom, S4, a + 1)
        bl.anota(S4, a, a + 2 + 2 * m, "enlaces_%04X" % a,
                 "ficha de enlaces de una zona: [casillas][n] y n parejas [casilla | lado bit 7]"
                 "[destino | lado bit 7] (0x7F, ninguno); sin enlace, cada casilla va a la de al "
                 "lado (p00:41AC)", "zona %d-%d" % (k // ZONAS + 1, k % ZONAS))


# ------------------------------------------------------------------ banco 9: jugador y pasadizos
def jugador_y_pasadizos(rom, t, bl):
    # las poses del jugador (p01:74A6): (0xC49F x 4 + 0xC4A2) en una de dos tablas
    for base, quien in ((0xAA56, "jugador 1"), (0xAA7E, "jugador 2")):
        bl.anota(S7, base, base + 40, "poses_%s" % quien.replace(" ", "_"),
                 "20 punteros, uno por (0xC49F x 4 + 0xC4A2), a la pose del %s: la lista de "
                 "sprites que p01:74CD copia a 0xEE00 (p01:74AA y 74AF, por el bit 7 de 0xC002)"
                 % quien, "p01:74BD")
        for k in range(20):
            a = palabra(rom, S7, base + 2 * k)
            bl.anota(S7, a, a + 1 + 2 * byte(rom, S7, a), "pose_%04X" % a,
                     "una pose: [n] y n parejas [y][x] relativas a 0xC498/0xC49A; el dibujo de "
                     "cada sprite es 4 x su orden (p01:7514)", "p01:74CD")
    # las formas de los pasadizos (p00:4F47): 9 filas de 16 bits
    bl.anota(S7, 0xAB18, 0xAB18 + 56 * 18, "formas_de_pasadizo",
             "56 formas de 9 filas x 2 bytes: cada bit puesto es un bloque de 16x16 que p00:4F94 "
             "pinta (la forma la escoge p01:6A49 en 0xEA00)", "p00:4F78")
    bl.anota(S7, 0xAF08, 0xAF08 + 2 * FASES * ZONAS, "pasadizos_de_cada_zona",
             "49 punteros, uno por zona, a sus 15 parejas de formas (p01:6B02)", "p01:6AFF")
    bl.anota(S7, 0xAF6A, 0xB04F, "pasadizos_tira",
             "la tira de numeros de pareja de la que cada zona coge 15 seguidos (0xAF08): las "
             "ventanas se pisan unas a otras, y la ultima (0xB04B) sigue 11 bytes dentro de la "
             "tabla 0xB04F", "p01:6B0A")
    bl.anota(S7, 0xB04F, 0xB21B, "parejas_de_formas",
             "230 parejas de formas de pasadizo (0-55) que p01:6B11 copia a 0xEA00", "p01:6B11")
    bl.anota(S7, 0xB21B, 0xB21B + 2 * FASES * ZONAS, "salidas_de_cada_zona",
             "49 punteros, uno por zona, a su lista de salidas (p01:6B27)", "p01:6B24")
    for k in range(FASES * ZONAS):
        a = palabra(rom, S7, 0xB21B + 2 * k)
        bl.anota(S7, a, a + 1 + 2 * byte(rom, S7, a), "salidas_%04X" % a,
                 "[n] y n parejas que p01:6B2E copia a 0xEA80 y p01:6B43 a 0xEB00 (bits 0-4 y "
                 "5-7 del segundo byte por separado)", "zona %d-%d" % (k // ZONAS + 1, k % ZONAS))

    # las cosas de cada casilla (p01:7D9E)
    bl.anota(S7, 0xB5D6, 0xB5D6 + 2 * FASES * ZONAS, "cosas_de_cada_zona",
             "49 punteros, uno por zona, a su lista de cosas por casilla (p01:7DAE)", "p01:7DAB")
    for k in range(FASES * ZONAS):
        a = palabra(rom, S7, 0xB5D6 + 2 * k)
        bl.anota(S7, a, a + 1 + 2 * byte(rom, S7, a), "cosas_%04X" % a,
                 "[n] y n parejas [casilla | bit 7][valor]: en la casilla 0xC281, p01:7DDA deja en "
                 "0xC520 un 1 (2 con el bit 7) y el valor", "zona %d-%d" % (k // ZONAS + 1, k % ZONAS))


# ------------------------------------------------------------------ banco 9: tablas por tipo
S9 = (1, 2, 9)              # p01:7983, p02:99FF: el 9 en 0xA000 sobre los de siempre
N_FIGURAS = 0x21            # tipos de figura 1-0x21 (los jefes 0x22-0x24 van aparte)


def tablas_del_banco_9(rom, t, bl):
    bl.anota(S9, 0xB84C, 0xB84C + N_FIGURAS, "puntos_de_cada_figura",
             "33 bytes, uno por tipo de figura 1-0x21 (ix+0): las centenas de puntos en BCD que "
             "suma p00:437E al acabar con ella (p01:7996)", "p01:798E")
    bl.anota(S9, 0xB86D, 0xB86D + N_FIGURAS, "dinero_de_cada_figura",
             "33 bytes, uno por tipo de figura: el dinero que suma p00:5929 (p01:79B9); los tipos "
             "8 y 0x21 no van por aqui, restan 50 con p00:5958", "p01:79B3")
    bl.anota(S9, 0xB88E, 0xB88E + N_FIGURAS, "tamano_de_cada_figura",
             "33 bytes, uno por tipo de figura: 1, 2 o 3, el tamano de su caja de choque "
             "(p01:7A99: 3 es 7 de alto, el resto 15)", "p01:7A93")
    bl.anota(S9, 0xB8AF, 0xB8AF + FASES * ZONAS, "casilla_de_entrada",
             "49 bytes, uno por zona: la casilla 0xC281 en la que se empieza (p01:66A5)", "p01:66A2")
    bl.anota(S9, 0xB8E0, 0xB8EC, "seis_sitios_B8E0",
             "6 parejas [y][x] que p01:676C recorre del ultimo al primero y pasa a p01:781F",
             "p01:676C")
    bl.anota(S9, 0xB8EC, 0xB8EC + FASES * ZONAS, "juego_de_cada_zona",
             "49 bytes, uno por zona: el juego de graficos 0xC289 (p01:664F); p02:81FD lee los "
             "siete de la fase", "p01:6649")
    bl.anota(S9, 0xB91D, 0xB95F, "dibujos_de_caracteres",
             "33 punteros a dibujos hechos de caracteres que p02:99FB pinta con 0x4EF1", "p02:9A07")
    for k in range(33):
        a = palabra(rom, S9, 0xB91D + 2 * k)
        bl.anota(S9, a, a + 3 + 14 * byte(rom, S9, a), "dibujo_car_%04X" % a,
                 "[ancho][posicion] y 14 filas de 'ancho' caracteres (nibbles: fila y columna en "
                 "la hoja de caracteres) que p02:9A19 pinta de 8 en 8", "p02:9A0E")


def rellenos(rom, t, bl):
    """Los 0xFF con los que acaba un banco, si son 16 o mas: no los lee nadie.

    El banco 3 acaba ademas en la marca oculta de Konami (tools/marca_konami.py):
    el titulo al reves, [11], [0x48] de RC-748 y [0xAA]."""
    for b in range(N_PAGINAS):
        blq = rom[b * TAM_PAGINA:(b + 1) * TAM_PAGINA]
        if b == 3:
            n = blq[-3]
            bl.anota(S1, 0xC000 - 3 - n, 0xC000, "marca_de_konami",
                     "la marca que Konami escondio al final del banco: el titulo al reves en %d "
                     "caracteres del propio juego (35 63 5D 49 63 59 39 63 33 52 5D, o sea "
                     "ka-dakuten-n-ha-dakuten-re-ko-dakuten-e-mo-n: GANBARE GOEMON), [%d], [0x48] del "
                     "RC-748 y [0xAA]; no la lee el cartucho (la destapo Manuel Pazos)" % (n, n),
                     "nadie")
            blq = blq[:-3 - n]
        i = len(blq)
        while i > 0 and blq[i - 1] == 0xFF:
            i -= 1
        if len(blq) - i >= 16:
            s = {0: S1, 1: S1, 2: S1, 3: S1}.get(b) or (
                tuple(b if ORG[b] == r else x for r, x in zip((0x6000, 0x8000, 0xA000), S1)))
            ini = ORG[b] + i
            for (a, f) in bl.d.get(b, {}):
                if a < ini < f:
                    ini = f                     # el 0xFF que acaba el ultimo bloque es suyo
            i = ini - ORG[b]
            bl.anota(s, ORG[b] + i, ORG[b] + len(blq), "relleno_%02d" % b,
                     "%d bytes 0xFF hasta el final del banco%s: relleno, no lo lee nadie"
                     % (len(blq) - i, " (o hasta la marca de Konami)" if b == 3 else ""),
                     "nadie")


# ------------------------------------------------------------------ banco 15: lo que hay en cada casilla
S15 = (1, 2, 15)            # p02:90C1, p02:961B: el 15 en 0xA000


def fin_texto(rom, s, a):
    """El texto que p00:42F1 escribe letra a letra: 0xFF o 0xE0 acaban, 0xFE
    baja una fila, 0xE1-0xFD corren (n - 0xE0) x 8 pixeles."""
    for _ in range(2000):
        c = byte(rom, s, a)
        a += 1
        if c in (0xFF, 0xE0):
            return a
    raise FueraDelBanco("texto sin fin desde 0x%04X" % a)


def banco_15(rom, t, bl):
    bl.anota(S15, 0xA02B, 0xA03D, "piezas",
             "9 punteros a las piezas de decorado que p02:9132 pinta (el numero es el nibble "
             "bajo del tercer byte de cada cosa de 0xA08E)", "p02:9132")
    for k in range(9):
        a = palabra(rom, S15, 0xA02B + 2 * k)
        f = a + 2
        if byte(rom, S15, a + 1) != 0xFF:
            while byte(rom, S15, f) != 0xFF:
                f += 2
            f += 1
        bl.anota(S15, a, f, "pieza_%d" % k,
                 "pieza %d: [x][y] del bloque de 16x16 en la hoja de la VRAM (y 0xFF, ninguna) y "
                 "parejas [dx][dy] donde pintarlo con p00:4E84; 0xFF acaba" % k, "p02:9139")
    bl.anota(S15, 0xA08E, 0xA08E + 2 * FASES * ZONAS, "cosas_fijas_de_cada_zona",
             "49 punteros, uno por zona, a las cosas fijas de sus casillas (p02:90E5)", "p02:90D5")
    for k in range(FASES * ZONAS):
        a = palabra(rom, S15, 0xA08E + 2 * k)
        bl.anota(S15, a, a + 2 + 3 * byte(rom, S15, a), "cosas_fijas_%04X" % a,
                 "[n], n fichas de 3 bytes [casilla][x | figura][y | pieza] y un 0xFF: si el nibble "
                 "bajo del segundo no es 0 p02:8FD5 pone una figura; el del tercero es la pieza "
                 "(0xA02B); el 0xFF hace de casilla que no es ninguna, para que p02:90EE pare tras "
                 "la ultima ficha",
                 "zona %d-%d" % (k // ZONAS + 1, k % ZONAS))
    bl.anota(S15, 0xB36D, 0xB38D, "piezas_del_subsuelo",
             "16 punteros a listas de bloques que p02:9155 pinta en los pasadizos", "p02:9155")
    for k in range(16):
        a = palabra(rom, S15, 0xB36D + 2 * k)
        f = a
        while byte(rom, S15, f) != 0xFF:
            f += 2
        bl.anota(S15, a, f + 1, "subsuelo_%04X" % a,
                 "parejas [x][y] de bloques de la hoja que p02:915C pinta; 0xFF acaba", "p02:915C")
    bl.anota(S15, 0xB3BE, 0xB3BE + 2 * FASES * ZONAS, "huecos_de_cada_zona",
             "49 punteros, uno por zona, a sus fichas de pasadizo (p02:9231)", "p02:922E")
    for k in range(FASES * ZONAS):
        a = palabra(rom, S15, 0xB3BE + 2 * k)
        f = a
        for _ in range(400):
            f += 2
            if byte(rom, S15, f - 1) & 0x04:
                break
        bl.anota(S15, a, f, "huecos_%04X" % a,
                 "parejas [x | figura][y | banderas] que p02:9239 copia a 0xCDE0, cuatro por "
                 "pasadizo (0xC484 x 8): el bit 3 del segundo byte cierra el pasadizo y rellena "
                 "lo que falta con 0xFF; el bit 2 acaba la lista", "zona %d-%d" % (k // ZONAS + 1, k % ZONAS))
    bl.anota(S15, 0xBC16, 0xBC16 + 2 * 35, "textos_de_cada_zona",
             "35 punteros, uno por (fase x 5 + zona - 1), al texto que p02:962F escribe con "
             "p00:42E1 al llegar", "p02:9625")
    for k in range(35):
        a = palabra(rom, S15, 0xBC16 + 2 * k)
        bl.anota(S15, a, fin_texto(rom, S15, a), "texto_%04X" % a,
                 "texto que p00:42F1 escribe letra a letra (0xFF o 0xE0 acaba, 0xFE baja una "
                 "fila, 0xE1-0xFD dejan hueco)", "p02:962F")


# ------------------------------------------------------------------ banco 12: rotulos y poses
S12B = (1, 2, 12)           # p02:87F3: el 12 en 0xA000 sobre los de siempre
N_ROTULOS = 114


def banco_12(rom, t, bl):
    bl.anota(S12, 0xA783, fin_rle(rom, S12, 0xA783, False), "rle_A783",
             "rle a la VRAM 0xF9C0 (p00:53F6) para el jugador 1; el del 2 es 0xA7DD (p00:53EB-53F0)",
             "p00:53F6")
    bl.anota(S12, 0xA9C0, 0xA9C0 + 2 * 120, "rotulos",
             "120 punteros a los rotulos que p00:4280 escribe con 0x48F3 (el numero lo pasa quien "
             "llama, hasta 0x70); los seis ultimos apuntan a 0xB6D2, donde acaban los rotulos: "
             "no hay rotulo 114-119", "p00:4288")
    for k in range(N_ROTULOS):
        a = palabra(rom, S12, 0xA9C0 + 2 * k)
        bl.anota(S12, a, fin_rotulo(rom, S12, a), "rotulo_%d" % k,
                 "rotulo %d: [x][y] y caracteres, 0xFE otra posicion, 0xFF acaba (0x48F3)" % k,
                 "p00:428F")
    bl.anota(S12B, 0xB6D2, 0xB7FE, "poses_de_figura",
             "150 punteros, uno por pose de figura (ix+0x0A), a su ficha de sprites (p02:8800)",
             "p02:8800")
    bl.anota(S12B, 0xB7FE, 0xBAF3, "fichas_de_pose",
             "las fichas de pose: [desplazamientos] (el numero de la lista de 0xBAF3) y el dibujo "
             "de cada sprite; cuantos sprites lleva lo dice (ix+0x20), que pone quien crea la "
             "figura, asi que cada ficha llega hasta la siguiente (p02:8806, 8831)", "p02:8806")
    bl.anota(S12B, 0xBAF3, 0xBB3F, "desplazamientos_de_pose",
             "38 punteros a listas de desplazamientos de sprite (p02:8809)", "p02:8809")
    bl.anota(S12B, 0xBB3F, 0xBCD3, "listas_de_desplazamientos",
             "parejas [dy][dx] de cada sprite respecto a (ix+3, ix+5), un dx negativo con el bit 7 "
             "(p02:8821, 883C); cada lista llega hasta la siguiente", "p02:8821")
    bl.anota(S12B, 0xBCD3, 0xBCE1, "palabras",
             "7 punteros a trozos de texto que p01:656E junta en 0xD800 separados por 0xFE 0xFE",
             "p01:656B")
    for k in range(7):
        a = palabra(rom, S12B, 0xBCD3 + 2 * k)
        bl.anota(S12B, a, a + 1 + byte(rom, S12B, a), "palabra_%d" % k,
                 "trozo de texto %d: [n] y n caracteres (p01:6573 los copia con ldir)" % k, "p01:6571")
    bl.anota(S1, 0x6589, 0x6591, "frases",
             "4 punteros (0xC26A = 7 y el bit de B, p01:655A) a las frases de p01:6567", "p01:655C")
    for a in (0x6591, 0x6594, 0x6599, 0x659D):
        bl.anota(S1, a, a + 1 + byte(rom, S1, a), "frase_%04X" % a,
                 "[n] y n numeros de trozo de texto (0xBCD3) que p01:6567 junta", "p01:6562")


# ------------------------------------------------------------------ cabecera y despachador
def tablas_del_despachador(rom, t, bl):
    """Las tablas de destinos pegadas detras de cada `call 0x408D`.

    Las mide tools/bancos.py (hasta el destino mas bajo, o lo que diga
    src/tablas.txt) y ya estan en el .nocode para que el trazador no entre;
    aqui se declaran como datos, con cuantos destinos tienen.
    """
    for (b, pc), (tab, n, dest, ss) in sorted(t.tablas.items()):
        if not n:
            continue
        bl.anota(ss, tab, tab + 2 * n, "tabla_%04X" % tab,
                 "%d destinos del despachador de 0x408D (call en %s:%04X): %s"
                 % (n, nombre(b), pc, ", ".join("0x%04X" % w for w in dest[:8])
                    + (" ..." if n > 8 else "")),
                 "%s:%04X" % (nombre(b), pc), ancho=2)


def cabecera(rom, t, bl):
    """0x4000-0x4044: la cabecera AB y la que lee el Konami Game Master."""
    bl.anota(S1, 0x4000, 0x4010, "cabecera_ab",
             "la cabecera del cartucho: 'AB', INIT (0x4097) y STATEMENT, DEVICE y TEXT a cero",
             "la BIOS", ancho=16)
    bl.anota(S1, 0x4010, 0x4045, "cabecera_de_konami",
             "la cabecera de Konami que lee el Game Master desde la otra ranura: 'CD', 0x07 0x48 "
             "(RC-748) y, detras, direcciones de la RAM del juego (0xC004, 0xC280, 0xC260...); el "
             "propio cartucho no la lee", "el Game Master", ancho=8)


# ------------------------------------------------------------------ banco 8: los dibujos del jugador
def banco_8(rom, t, bl):
    bl.anota(S7, 0x92D9, 0x92F9, "dibujo_92D9",
             "un dibujo de 8x8 a 4 bits (0x4879) que p00:4AFA sube dos veces en el juego 5; los "
             "otros dos son 0x92F9", "p00:4B07")
    for base, quien in ((0x9319, "jugador 1"), (0x9341, "jugador 2")):
        bl.anota(S7, base, base + 40, "sprites_%s" % quien.replace(" ", "_"),
                 "20 punteros, uno por pose (0xC49F x 4 + 0xC4A2), a los sprites del %s en rle, "
                 "que p00:4CCE sube a 0xF800 (p00:4CB2/4CB7 por el bit 7 de 0xC002)" % quien,
                 "p00:4CC5")
        for k in range(20):
            a = palabra(rom, S7, base + 2 * k)
            bl.anota(S7, a, fin_rle(rom, S7, a, False), "sprites_%04X" % a,
                     "los sprites de una pose del %s, en rle a 0xF800 (0x4539)" % quien, "p00:4CCE")


# ------------------------------------------------------------------ los colores de los sprites
def colores_de_sprite(rom, t, bl):
    """p00:54E6: el color de cada linea de los sprites de una figura. La tabla
    0x554E da, por (0xCD37 - 1) x 2 + el bit 0 de (ix+0x0A), una lista de
    tripletes [n][desde][color] (0 acaba) que p00:5537 pinta sobre los 16
    bytes de color de cada sprite."""
    bl.anota(S1, 0x554E, 0x5626, "colores_de_cada_pose",
             "108 punteros, dos por cada uno de los 54 juegos de color (0xCD37 - 1), el segundo "
             "para la figura mirando al otro lado (bit 0 de ix+0x0A) (p00:54E7)", "p00:54E7")
    bl.anota(S1, 0x5626, 0x57FA, "listas_de_color",
             "las listas de color de las poses: cada entrada de 0x554E apunta a tantas listas "
             "seguidas como sprites tiene la figura (ix+0x20, que pone p02:835C), y cada lista son "
             "tripletes [n][desde][color] que p00:5537 pinta sobre los 16 bytes de color del "
             "sprite, con un 0 al final; unas entradas empiezan dentro de las listas de otras. "
             "Lo ultimo (desde 0x57BE, donde acaba la primera lista de la ultima entrada) solo lo "
             "lee una pose con mas sprites; eso no esta medido", "p00:5537")
    # el conjunto 13 del juego 4, que ninguna casilla usa
    bl.anota(S1, 0x5C46, 0x5C48, "conjunto_13_juego_4",
             "un decimocuarto puntero de los conjuntos del juego 4 (0x5D81); ninguna casilla de "
             "las zonas de ese juego pide el 13", "nadie")
    bl.anota(S1, 0x5D81, 0x5D85, "figuras_5D81",
             "el conjunto al que apunta 0x5C46: [2] y los tipos 0, 0x16 y 0x15; no lo pide nadie",
             "nadie")


RECORRIDOS = [llamadas_a_lectores, mapas, sonido, figuras, caracteres, paletas_y_planos, jugador_y_pasadizos,
              tablas_del_banco_9, banco_15, banco_12, tablas_del_despachador, cabecera,
              banco_8, colores_de_sprite, rellenos]


# ------------------------------------------------------------------ escritura
def ocupado(p):
    """bytearray del banco: 1 = codigo trazado, 2 = D escrita fuera de la seccion."""
    o = ORG[p]
    m = bytearray(TAM_PAGINA)
    ruta = os.path.join(WORK, nombre(p) + ".trace.json")
    if os.path.exists(ruta):
        for k, a, b in json.load(open(ruta))["blocks"]:
            if k == "c":
                for i in range(a - o, b - o):
                    m[i] = 1
    notas = os.path.join(SRC, nombre(p) + ".notes")
    dentro = False
    if os.path.exists(notas):
        for ln in open(notas, encoding="utf-8"):
            if ln.startswith(INI):
                dentro = True
            elif ln.startswith(FIN):
                dentro = False
            elif not dentro and ln.startswith("D "):
                q = ln.split(None, 3)
                for i in range(max(0, int(q[1], 0) - o), min(TAM_PAGINA, int(q[2], 0) - o)):
                    m[i] = 2
    return m


def une(bloques_banco):
    """Los que se solapan se juntan en uno: dos juegos que comparten dibujos."""
    fuera = []
    for (a, f), e in sorted(bloques_banco.items()):
        if fuera and a < fuera[-1][1]:
            pa, pf, pe = fuera[-1]
            fuera[-1] = (pa, max(pf, f), pe + [(a, f, e)])
        else:
            fuera.append((a, f, [(a, f, e)]))
    return fuera


def linea_d(a, f, partes):
    e0 = partes[0][2]
    desde = sorted({d for _, _, e in partes for d in e["desde"]})
    if len(partes) == 1:
        txt = e0["que"]
    else:
        txt = "%s; se solapan %d bloques (%s)" % (
            e0["que"], len(partes),
            ", ".join("0x%04X-0x%04X" % (x, y) for x, y, _ in partes[:6]))
    desde = [d for d in desde if d != "nadie"]
    if desde:
        txt += "; lo leen %s" % ", ".join(desde[:8])
    if len(desde) > 8:
        txt += " y %d mas" % (len(desde) - 8)
    txt += " (%d bytes)" % (f - a)
    return ["D 0x%04X 0x%04X %s  %s" % (a, f, e0["nom"], txt), "F 0x%04X %d" % (a, e0["ancho"])]


def escribe(p, lineas):
    ruta = os.path.join(SRC, nombre(p) + ".notes")
    viejas = open(ruta, encoding="utf-8").read().split("\n") if os.path.exists(ruta) else []
    nuevas, dentro, puesto = [], False, False
    for ln in viejas:
        if ln.startswith(INI):
            dentro = True
            if lineas:
                nuevas += [INI] + lineas + [FIN]
            puesto = True
            continue
        if ln.startswith(FIN):
            dentro = False
            continue
        if not dentro:
            nuevas.append(ln)
    if not puesto and lineas:
        while nuevas and not nuevas[-1].strip():
            nuevas.pop()
        nuevas += ["", INI] + lineas + [FIN, ""]
    open(ruta, "w", encoding="utf-8", newline="\n").write("\n".join(nuevas).rstrip("\n") + "\n")


def main(argv):
    rom = open(ROM, "rb").read()
    t, _ = traza_completa(rom, SRC)
    bl = Bloques()
    for r in RECORRIDOS:
        try:
            r(rom, t, bl)
        except FueraDelBanco as e:
            bl.avisos.append("%s: %s" % (r.__name__, e))
    total = 0
    for p in range(N_PAGINAS):
        m = ocupado(p)
        buenas, conflictos = [], []
        for a, f, partes in une(bl.d.get(p, {})):
            marcas = set(m[i - ORG[p]] for i in range(a, f))
            if marcas == {2}:
                continue
            pisa = marcas - {0}
            if pisa:
                conflictos.append("  %s 0x%04X-0x%04X (%s) pisa %s" % (
                    nombre(p), a, f, partes[0][2]["nom"],
                    " y ".join({1: "codigo trazado", 2: "una D escrita a mano"}[x] for x in sorted(pisa))))
                continue
            buenas.append((a, f, partes))
        n = sum(f - a for a, f, _ in buenas)
        total += n
        if buenas or conflictos:
            print("%s: %d bloques, %d bytes%s" % (nombre(p), len(buenas), n,
                                                  ", %d en conflicto" % len(conflictos) if conflictos else ""))
            for c in conflictos:
                print(c)
        if "--escribe" in argv:
            lineas = []
            for a, f, partes in buenas:
                lineas += linea_d(a, f, partes)
            escribe(p, lineas)
    print("en total: %d bytes en bloques que lee el codigo" % total)
    if bl.avisos:
        print("%d avisos:" % len(bl.avisos))
        for x in sorted(set(bl.avisos))[:80]:
            print("  " + x)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
