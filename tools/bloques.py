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
    # la rejilla de cada zona
    juego = juego_de_cada_zona(rom)
    bl.anota(s, 0x600C, 0x600C + 2 * FASES * ZONAS, "rejilla_de_cada_zona",
             "49 punteros, uno por zona (fase x 7 + zona): la rejilla de pantallas que p00:5311 "
             "copia en 0xE700", "p00:5317")
    for k in range(FASES * ZONAS):
        a = palabra(rom, s, 0x600C + 2 * k)
        n = 64 if juego[k] < 4 else 128
        bl.anota(s, a, a + n, "rejilla_%04X" % a,
                 "rejilla de pantallas de una zona: %s (p00:5311); las zonas comparten bytes"
                 % ("64 bytes, dos casillas por byte" if n == 64 else "128 bytes, una casilla por byte"),
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


RECORRIDOS = [llamadas_a_lectores, mapas]


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
