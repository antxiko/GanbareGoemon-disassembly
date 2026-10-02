#!/usr/bin/env python3
"""Las pantallas de Ganbare Goemon, montadas desde las tablas como las monta el
cartucho, sin ejecutar ni una instruccion suya.

El juego corre en SCREEN 5 (p00:4994) y guarda en la pagina 1 de la VRAM
(0x8000-0xFFFF) un almacen de CARACTERES de 8x8 puntos a 4 bits: el k esta en
x = (k % 32) * 8, y = (k / 32) * 8 (p00:4976). Cada zona carga los suyos y
cada pantalla se monta con ellos:

  p01:663A  la carga de la zona: el juego de graficos 0xC289 sale de la tabla
            0xB8EC (banco 9) por fase x 7 + zona; p00:4DA4 sube los dibujos de
            siempre (16x16 a 0xC000 y los del marcador con HMMC) y p00:4A96 los
            caracteres del juego: rle (0x4C4B) a 0xD000 y de ahi a la VRAM
            (0x488E desde 0x8004; algunos, dados la vuelta, con 0x4C75), mas
            los del banco 7 que comparten todos los juegos.
  p00:4CE3  la paleta: la base (0xA3E6) y la del juego (0xA37A), listas de
            [color][RB][G] hasta 0xFF (p00:4666).
  p00:51ED  el montaje: la casilla 0xC281 da la pantalla en la rejilla 0xE700;
            la pantalla son 8 x 6 bloques (48 bytes en 0xD000) y cada bloque
            4 x 4 caracteres (16 bytes en 0xE100). Sale 0xD800, 32 por fila.
  p00:534E  y la pintada: 22 filas de 32 caracteres, cada uno un HMMM de 8x8
            de la pagina 1 a la 0, desde la linea 0x20 (p00:5361).

Uso:  graficos.py <fase 1-7> <zona 0-6> <casilla> [salida.png]
"""
import os
import struct
import sys
import zlib

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from paginas import TAM_PAGINA, N_PAGINAS  # noqa: E402

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
ROM = os.path.join(RAIZ, "goemon.rom")
IMAGENES = os.path.join(RAIZ, "docs", "imagenes")

ANCHO_DE_LINEA = 128                  # bytes por linea en SCREEN 5
S1 = (1, 2, 3)                        # p00:4206
S4 = (4, 5, 6)                        # p00:4220
S7 = (7, 8, 9)                        # p00:4238
S10 = (10, 11, 12)                    # p00:4250
S13 = (13, 14, 15)                    # p00:4268
FASES, ZONAS = 7, 7
LINEA_DE_LA_PANTALLA = 0x20           # p00:535F: e = 0x20
FILAS = 22                            # p00:5366


class Cartucho:
    """Los 128 KB con el mapper puesto: `bancos` es (b6000, b8000, bA000)."""

    def __init__(self, ruta=ROM):
        with open(ruta, "rb") as f:
            self.rom = f.read()
        if len(self.rom) != TAM_PAGINA * N_PAGINAS:
            raise SystemExit("la ROM mide %d bytes y no %d" % (len(self.rom), TAM_PAGINA * N_PAGINAS))

    def leer(self, addr, bancos):
        if 0x4000 <= addr < 0x6000:
            b = 0
        elif 0x6000 <= addr < 0xC000:
            b = bancos[(addr - 0x6000) >> 13]
        else:
            raise ValueError("%#06x no cae en el cartucho" % addr)
        return self.rom[b * TAM_PAGINA + (addr & 0x1FFF)]

    def palabra(self, addr, bancos):
        return self.leer(addr, bancos) | (self.leer(addr + 1, bancos) << 8)


class Vram:
    """Los 128 KB del V9938 y la paleta, con la cuenta de lo tocado."""

    def __init__(self):
        self.v = bytearray(0x20000)
        self.tocado = bytearray(0x20000)
        self.paleta = [(0, 0, 0)] * 16

    def escribe(self, a, valor):
        a &= 0x1FFFF
        self.v[a] = valor
        self.tocado[a] = 1

    def punto(self, pagina, x, y):
        b = self.v[pagina * 0x8000 + y * ANCHO_DE_LINEA + (x >> 1)]
        return b >> 4 if x & 1 == 0 else b & 0x0F

    def pon_punto(self, pagina, x, y, c):
        a = pagina * 0x8000 + y * ANCHO_DE_LINEA + (x >> 1)
        b = self.v[a]
        self.escribe(a, (c << 4) | (b & 0x0F) if x & 1 == 0 else (b & 0xF0) | c)


# ------------------------------------------------------------ los lectores
def rle(cart, bancos, de, escribe):
    """p00:4539 / p00:42C3: 0 acaba; 0x01-0x7F repite el byte que sigue; 0x80
    trae otro destino (dos bytes); 0x81-0xFF van tal cual n & 0x7F bytes.
    `escribe(n, byte)` recibe cada byte; devuelve donde acaba."""
    while True:
        b = cart.leer(de, bancos)
        de += 1
        if b == 0:
            return de
        n = b & 0x7F
        if n == b:
            v = cart.leer(de, bancos)
            de += 1
            for _ in range(n):
                escribe(None, v)
        elif n == 0:
            escribe(cart.palabra(de, bancos), None)
            de += 2
        else:
            for _ in range(n):
                escribe(None, cart.leer(de, bancos))
                de += 1


def rle_a_la_vram(cart, bancos, dest, de, vram):
    """p00:4539: HL es el destino en la VRAM (la pagina en los dos bits altos)."""
    estado = [dest]

    def escribe(nuevo, v):
        if nuevo is not None:
            estado[0] = nuevo
            return
        vram.escribe(estado[0], v)
        estado[0] += 1
    return rle(cart, bancos, de, escribe)


def rle_a_la_ram(cart, bancos, de, tam=0x2000):
    """p00:42C3: lo mismo a un bufer de RAM; devuelve el bufer."""
    buf = bytearray(tam)
    estado = [0]

    def escribe(nuevo, v):
        if nuevo is not None:
            raise ValueError("un 0x80 en un rle a la RAM")
        buf[estado[0]] = v
        estado[0] += 1
    rle(cart, bancos, de, escribe)
    return buf


def _siguiente(dest, paso, alto):
    e = (dest & 0xFF) + paso
    if e == 0x80:
        return ((dest >> 8) + alto) << 8
    return (dest & 0xFF00) | e


def sube_dibujos(fuente, dest, n, vram):
    """p00:488E: n caracteres de 32 bytes (8 filas de 4) desde `fuente`, una
    lista de bytes, de 4 en 4 a la derecha y al borde ocho lineas mas abajo."""
    k = 0
    for _ in range(n):
        for fila in range(8):
            for j in range(4):
                vram.escribe(dest + fila * ANCHO_DE_LINEA + j, fuente[k])
                k += 1
        dest = _siguiente(dest, 4, 4)


def sube_dibujos_vueltos(fuente, dest, n, vram):
    """p00:4C75: como 0x488E, pero cada fila al reves (los cuatro bytes en el
    otro orden y los dos puntos de cada byte cambiados): el caracter mirando al
    otro lado."""
    k = 0
    for _ in range(n):
        for fila in range(8):
            b = fuente[k:k + 4]
            k += 4
            for j in range(4):
                x = b[3 - j]
                vram.escribe(dest + fila * ANCHO_DE_LINEA + j, ((x & 0x0F) << 4) | (x >> 4))
        dest = _siguiente(dest, 4, 4)


def sube_dibujos_de_16(fuente, dest, n, vram):
    """p00:48B8: n dibujos de 16x16 (16 filas de 8 bytes), de 8 en 8 bytes a
    la derecha y al borde dieciseis lineas mas abajo."""
    k = 0
    for _ in range(n):
        for fila in range(16):
            for j in range(8):
                vram.escribe(dest + fila * ANCHO_DE_LINEA + j, fuente[k])
                k += 1
        dest = _siguiente(dest, 8, 8)


def de_la_rom(cart, bancos, hl, n):
    return bytes(cart.leer(hl + k, bancos) for k in range(n))


def hmmc(fuente, x, y, ancho, alto, pagina, vram):
    """p00:47B2: ancho x alto puntos a la VRAM en (x, y) de la pagina."""
    ancho = ancho or 256
    alto = alto or 256
    k = 0
    for fila in range(alto):
        for j in range(ancho // 2):
            vram.escribe(pagina * 0x8000 + (y + fila) * ANCHO_DE_LINEA + (x >> 1) + j, fuente[k])
            k += 1


def letras(fuente, x, y, n, color, vram, pagina=1):
    """p00:484F: n caracteres de 8x8 a 1 bit; cada bit puesto es un punto del
    color C y el resto 0. Van de 8 en 8 a la derecha desde (x, y) de la
    pagina 1 y, al pasar de 256, ocho lineas mas abajo (p00:4984)."""
    k = 0
    for _ in range(n):
        for fila in range(8):
            b = fuente[k]
            k += 1
            for bit in range(8):
                vram.pon_punto(pagina, x + bit, y + fila, color if b & (0x80 >> bit) else 0)
        x += 8
        if x >= 256:
            x = 0
            y += 8


def hmmm(vram, sx, sy, dx, dy, ancho, alto, origen, destino):
    """p00:476E: copia un rectangulo de puntos de una pagina a otra."""
    for fila in range(alto):
        for j in range(ancho):
            vram.pon_punto(destino, dx + j, dy + fila, vram.punto(origen, sx + j, sy + fila))


def pon_paleta(cart, bancos, hl, vram):
    """p00:4666: [color][RB][G] hasta 0xFF; tres bits por componente."""
    while True:
        c = cart.leer(hl, bancos)
        if c == 0xFF:
            return
        rb, g = cart.leer(hl + 1, bancos), cart.leer(hl + 2, bancos)
        vram.paleta[c & 0x0F] = ((rb >> 4) & 7, g & 7, rb & 7)
        hl += 3


# ------------------------------------------------------------ la zona
def juego_de_la_zona(cart, z):
    """p01:6644: el juego de graficos de la zona z (fase x 7 + zona)."""
    return cart.leer(0xB8EC + z, (1, 2, 9))


def carga_de_siempre(cart, vram):
    """p00:4DA4: los dibujos de 16x16 a 0xC000 y los del marcador (HMMC)."""
    sube_dibujos_de_16(de_la_rom(cart, S7, 0x6F60, 21 * 128), 0xC000, 21, vram)
    sube_dibujos_de_16(de_la_rom(cart, S7, 0x79E0, 4 * 128), 0xC830, 4, vram)
    sube_dibujos_de_16(de_la_rom(cart, S7, 0x7BE0, 3 * 128), 0xC858, 3, vram)
    for hl, de, bc in ((0x7D60, 0x00A0, 0x2003), (0x7D90, 0x00A4, 0x0814),
                       (0x7DE0, 0x18A4, 0x0814), (0x7E30, 0x00B8, 0x2008),
                       (0x7EB0, 0x20A0, 0x2010), (0x7FB0, 0x20B0, 0x060F),
                       (0x7FDD, 0x3AB0, 0x060F), (0x800A, 0x90A0, 0x161B),
                       (0x8413, 0xC8A0, 0x1A1D), (0x8133, 0xA8A0, 0x0820),
                       (0x8233, 0x00C0, 0x0C10), (0x8293, 0x10C0, 0x0810),
                       (0x82D3, 0x18C0, 0x2010), (0x83D3, 0x00D0, 0x1008),
                       (0x81B3, 0xC0A0, 0x0820)):
        ancho, alto = bc >> 8, bc & 0xFF
        hmmc(de_la_rom(cart, S7, hl, ancho * alto // 2), de >> 8, de & 0xFF, ancho, alto, 1, vram)


def carga_los_caracteres(cart, juego, vram):
    """p00:4A96: los caracteres del juego de graficos y los que comparten todos."""
    de = cart.palabra(0x4C4B + 2 * juego, S1)
    d000 = rle_a_la_ram(cart, S4, de)

    def de_d000(dir_ram, n):
        return d000[dir_ram - 0xD000:dir_ram - 0xD000 + n]
    if juego == 3:                                  # p00:4B15
        sube_dibujos(de_d000(0xD000, 13 * 32), 0x8004, 13, vram)
        sube_dibujos_vueltos(de_d000(0xD040, 11 * 32), 0x8038, 11, vram)
        sube_dibujos(de_d000(0xD1A0, 22 * 32), 0x8064, 22, vram)
        sube_dibujos_vueltos(de_d000(0xD380, 7 * 32), 0x843C, 7, vram)
        sube_dibujos(de_d000(0xD460, 87 * 32), 0x8458, 87, vram)
        sube_dibujos_vueltos(de_d000(0xDD60, 15 * 32), 0x9034, 15, vram)
    else:
        sube_dibujos(de_d000(0xD000, 0x8A * 32), 0x8004, 0x8A, vram)
        f = 0x4C57 + 5 * juego                       # p00:4C0E
        dest = cart.palabra(f, S1)
        n = cart.leer(f + 2, S1)
        src = cart.palabra(f + 3, S1)
        if juego != 2:                               # p00:4AC3
            sube_dibujos_vueltos(de_d000(src, n * 32), dest, n, vram)
    # p00:4ACA: los del banco 7, para todos
    sube_dibujos(de_la_rom(cart, S7, 0x6000, 0x1E * 32), 0x9400, 0x1E, vram)
    sube_dibujos_vueltos(de_la_rom(cart, S7, 0x61A0, 0x11 * 32), 0x9478, 0x11, vram)
    sube_dibujos(de_la_rom(cart, S7, 0x63C0, 0x2A * 32), 0x983C, 0x2A, vram)
    if juego == 5:                                   # p00:4AF1
        dest = 0x941C
        for b in (4, 3, 2, 1):
            hl = 0x92D9 if b >= 3 else 0x92F9
            sube_dibujos(de_la_rom(cart, S7, hl, 32), dest, 1, vram)
            dest += 4


def pon_la_paleta(cart, juego, vram, sitio=0):
    """p00:4CE3: la base (p00:4CFC, 0xA3E6), encima la del juego (0xA37A) y
    encima los colores del sitio (p00:4D2C: 0xA4C5[juego][0xC267]). 0xC267
    vale 0 al entrar en la zona (p01:66B6) y la cambian las salidas."""
    pon_paleta(cart, S7, 0xA3E6, vram)
    pon_paleta(cart, S7, cart.palabra(0xA37A + 2 * juego, S7), vram)
    tabla = cart.palabra(0xA4C5 + 2 * juego, S7)
    pon_paleta(cart, S7, cart.palabra(tabla + 2 * sitio, S7), vram)


def carga_la_zona(cart, z, vram=None, sitio=0):
    vram = vram or Vram()
    juego = juego_de_la_zona(cart, z)
    carga_de_siempre(cart, vram)
    carga_los_caracteres(cart, juego, vram)
    if z % ZONAS == 6:                              # p01:66D1: en la zona 6
        hmmm(vram, 0x00, 0x80, 0x30, 0x80, 16, 16, 1, 1)   # el dibujo 3 = el 0
    pon_la_paleta(cart, juego, vram, sitio)
    return vram


# ------------------------------------------------------------ la pantalla
def casillas(cart, z):
    """p00:418E: el primer byte de la ficha de enlaces de la zona (0xB7D0)."""
    return cart.leer(cart.palabra(0xB7D0 + 2 * z, S4), S4)


def rejilla(cart, z):
    """p00:5311: la pantalla de cada casilla de la zona (0xE700)."""
    juego = juego_de_la_zona(cart, z)
    a = cart.palabra(0x600C + 2 * z, S13)
    fuera = []
    for c in range(casillas(cart, z)):
        if juego < 4:
            b = cart.leer(a + c // 2, S13)
            v = b >> 4 if c % 2 == 0 else b & 0x0F
            fuera.append(0xFF if v == 0x0F else v)
        else:
            fuera.append(cart.leer(a + c, S13))
    return fuera


def pantallas_y_bloques(cart, juego):
    """p00:4295 y p00:42AC: las pantallas (48 bytes) y los bloques (16)."""
    d000 = rle_a_la_ram(cart, S13, cart.palabra(0x6000 + 2 * juego, S13))
    e100 = rle_a_la_ram(cart, S13, cart.palabra(0x75B9 + 2 * juego, S13), 0x0600)
    return d000, e100


def monta(cart, z, casilla):
    """p00:51ED: los 32 x 24 caracteres de la pantalla de la casilla (0xD800)."""
    juego = juego_de_la_zona(cart, z)
    d000, e100 = pantallas_y_bloques(cart, juego)
    p = rejilla(cart, z)[casilla]
    if p == 0xFF:                                   # p00:5262: la pantalla 0x7419
        pantalla = de_la_rom(cart, S13, 0x7419, 48)
        bloques = de_la_rom(cart, S13, 0x7449, 16 * (max(pantalla) + 1))
    else:
        pantalla = d000[48 * p:48 * p + 48]
        bloques = e100
    celdas = [[0] * 32 for _ in range(24)]
    for fb in range(6):
        for cb in range(8):
            b = pantalla[8 * fb + cb]
            for f in range(4):
                for c in range(4):
                    celdas[4 * fb + f][4 * cb + c] = bloques[16 * b + 4 * f + c]
    return celdas


def pinta(vram, celdas, filas=FILAS, y0=LINEA_DE_LA_PANTALLA):
    """p00:534E: cada caracter, un HMMM de 8x8 de la pagina 1 a la 0."""
    for f in range(filas):
        for c in range(32):
            t = celdas[f][c]
            hmmm(vram, (t & 0x1F) * 8, (t >> 5) * 8, c * 8, y0 + f * 8, 8, 8, 1, 0)


S15 = (1, 2, 15)                      # p02:90C1: el 15 en 0xA000


def lmmm_timp(vram, sx, sy, dx, dy, ancho, alto, origen, destino):
    """p00:4803 con la operacion 0x48 (p00:4E95): LMMM con TIMP, o sea sin
    copiar los puntos de color 0."""
    for fila in range(alto):
        for j in range(ancho):
            c = vram.punto(origen, sx + j, sy + fila)
            if c:
                vram.pon_punto(destino, dx + j, dy + fila, c)


def cosas_fijas(cart, z, casilla, vram, celdas):
    """p02:90C0 fuera del subsuelo: las cosas fijas de la casilla (0xA08E).
    Cada ficha es [casilla][y | figura][x | pieza]; la pieza (0xA02B) da de
    donde sale el bloque de 16x16 en la pagina 1 ([sy][sx]) y las parejas
    [dy][dx] donde se pinta (p00:4E84); cada bloque deja sus cuatro
    caracteres de 0xD800 a 0xFF (p00:4F26), que es lo que no se puede pisar.
    Las figuras (nibble bajo del segundo byte, p02:8FD5) no se pintan aqui."""
    a = cart.palabra(0xA08E + 2 * z, S15)
    n = cart.leer(a, S15)
    k = a + 1
    for _ in range(n):
        if cart.leer(k, S15) == casilla:
            break
        k += 3
    else:
        return
    while cart.leer(k, S15) == casilla:
        b1, b2 = cart.leer(k + 1, S15), cart.leer(k + 2, S15)
        y0, x0, pieza = b1 & 0xF0, b2 & 0xF0, b2 & 0x0F
        p = cart.palabra(0xA02B + 2 * pieza, S15)
        sy, sx = cart.leer(p, S15), cart.leer(p + 1, S15)
        if sx != 0xFF:
            q = p + 2
            while cart.leer(q, S15) != 0xFF:
                dy = (y0 + cart.leer(q, S15)) & 0xFF
                dx = (x0 + cart.leer(q + 1, S15)) & 0xFF
                lmmm_timp(vram, sx, sy, dx, dy, 16, 16, 1, 0)
                for yy in (dy, dy + 8):
                    for xx in (dx, dx + 8):
                        f, c = ((yy - LINEA_DE_LA_PANTALLA) & 0xF8) // 8, (xx & 0xFF) // 8
                        if 0 <= f < 24:
                            celdas[f][c] = 0xFF
                q += 2
        k += 3


# ------------------------------------------------------------------ el plano de la zona
ARRIBA, ABAJO, IZQUIERDA, DERECHA = 0, 1, 2, 3
PASO = {ARRIBA: (0, -1), ABAJO: (0, 1), IZQUIERDA: (-1, 0), DERECHA: (1, 0)}


def enlaces(cart, z):
    """p00:4188: los cuatro vecinos de cada casilla (0xE780). Por defecto la
    casilla i tiene a la izquierda la i-1 y a la derecha la i+1 (p00:41AC); la
    ficha de 0xB7D0 trae los demas: [casilla | bit 7][destino | bit 7], con el
    lado en esos dos bits (arriba 0, abajo 1, izquierda 2, derecha 3: p01:71D1
    pone 3 al salir por la izquierda y 4 por la derecha, y p01:7240 deja al
    jugador abajo con el 1) y 0x7F, ninguno."""
    a = cart.palabra(0xB7D0 + 2 * z, S4)
    n = cart.leer(a, S4)
    v = [[None, None, None, None] for _ in range(n)]
    for i in range(n):
        if i > 0:
            v[i][IZQUIERDA] = i - 1
        if i < n - 1:
            v[i][DERECHA] = i + 1
    m = cart.leer(a + 1, S4)
    for k in range(m):
        b0, b1 = cart.leer(a + 2 + 2 * k, S4), cart.leer(a + 3 + 2 * k, S4)
        lado = ((b0 >> 7) << 1) | (b1 >> 7)
        d = b1 & 0x7F
        if (b0 & 0x7F) >= n:
            # la zona 3-0 (y la 6-1, misma ficha) trae un enlace desde la
            # casilla 38, que no existe (tiene 34): p00:41E3 lo escribe en
            # 0xE780 y nadie lo lee
            continue
        v[b0 & 0x7F][lado] = None if d == 0x7F else d
    return v


def plano(cart, z):
    """Las casillas puestas en una rejilla siguiendo los enlaces desde la 0:
    {casilla: (x, y)} y la lista de choques (dos casillas en el mismo sitio)."""
    v = enlaces(cart, z)
    sitio, choques, cola = {0: (0, 0)}, [], [0]
    while cola:
        c = cola.pop(0)
        x, y = sitio[c]
        for lado, d in enumerate(v[c]):
            if d is None:
                continue
            dx, dy = PASO[lado]
            nuevo = (x + dx, y + dy)
            if d in sitio:
                if sitio[d] != nuevo:
                    choques.append((c, lado, d))
                continue
            sitio[d] = nuevo
            cola.append(d)
    return sitio, choques


def rgb(paleta, c):
    r, g, b = paleta[c]
    return (r * 255 // 7, g * 255 // 7, b * 255 // 7)


def foto(vram, pagina=0, y0=LINEA_DE_LA_PANTALLA, alto=FILAS * 8):
    """Las lineas y0..y0+alto de una pagina, en RGB con la paleta de la VRAM."""
    return [[rgb(vram.paleta, vram.punto(pagina, x, y)) for x in range(256)]
            for y in range(y0, y0 + alto)]


def guarda_png(img, ruta, escala=1):
    """Un PNG RGB de una lista de filas de (r, g, b), sin librerias."""
    alto, ancho = len(img), len(img[0])
    filas = bytearray()
    for fila in img:
        cruda = bytearray()
        for p in fila:
            cruda += bytes(p) * escala
        for _ in range(escala):
            filas += b"\x00" + cruda

    def trozo(tipo, datos):
        c = tipo + datos
        return struct.pack(">I", len(datos)) + c + struct.pack(">I", zlib.crc32(c) & 0xFFFFFFFF)
    png = (b"\x89PNG\r\n\x1a\n" + trozo(b"IHDR", struct.pack(">IIBBBBB", ancho * escala, alto * escala, 8, 2, 0, 0, 0))
           + trozo(b"IDAT", zlib.compress(bytes(filas), 9)) + trozo(b"IEND", b""))
    os.makedirs(os.path.dirname(os.path.abspath(ruta)), exist_ok=True)
    with open(ruta, "wb") as f:
        f.write(png)
    return ruta


def pantalla(cart, z, casilla):
    v = carga_la_zona(cart, z)
    celdas = monta(cart, z, casilla)
    pinta(v, celdas)
    cosas_fijas(cart, z, casilla, v, celdas)
    return v


def main():
    if len(sys.argv) < 4:
        sys.exit(__doc__)
    cart = Cartucho()
    fase, zona, cas = int(sys.argv[1]), int(sys.argv[2]), int(sys.argv[3])
    z = (fase - 1) * ZONAS + zona
    v = pantalla(cart, z, cas)
    salida = sys.argv[4] if len(sys.argv) > 4 else os.path.join(
        RAIZ, "work", "pantalla_%d_%d_%02d.png" % (fase, zona, cas))
    print(guarda_png(foto(v), salida, escala=2))


if __name__ == "__main__":
    main()
