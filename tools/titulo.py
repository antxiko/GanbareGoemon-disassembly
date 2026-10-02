#!/usr/bin/env python3
"""Las dos pantallas del principio, dibujadas desde las tablas del cartucho.

  konami  p01:643F, el estado 0: la paleta de 0x6476, el fondo del color 15
          (R7 = 0x0F, p01:6448), las tres tiras de dibujos a 1 bit que p00:4A43
          sube a la pagina 1 en tres colores (0xBC92, 0xBCFA y 0xBD62, banco 6),
          y el cartel de 0x64C9, que p01:64A9 compone con ellas desde (0x40,
          0x40) caracter a caracter (HMMM de la pagina 1 a la 1). p01:6498 lo
          va pasando a la pagina 0 de arriba abajo hasta 0x30 lineas.
  titulo  p00:5A93, el estado 1: las letras (p00:4A6D) y los caracteres del
          titulo (p00:4B91: 46 desde 0x8004 y los dibujos de los sprites en rle
          de 0xB43C a 0xF800), la paleta de 0xA44E, 12 filas de 20 caracteres
          de 0xB6B2 desde (0x30, 0x20), los 23 sprites de 0xB7A2 (el color 5 en
          los siete primeros y el 4 en el resto, p00:5AD5-5AED), el marco de
          p00:4704 y los rotulos de 0x639B.

Uso:  titulo.py            escribe docs/imagenes/konami.png y titulo.png
      titulo.py coteja     las compara con los volcados de work/v_demo
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import graficos as G  # noqa: E402

S1, S4, S13 = G.S1, G.S4, G.S13


def caracter_de(t):
    """p00:4976: el caracter t de la pagina 1 esta en ((t % 32) * 8, (t / 32) * 8)."""
    return (t & 0x1F) * 8, (t >> 5) * 8


def hmmv(vram, x, y, ancho, alto, byte, pagina):
    """p00:4732: rellena un rectangulo con un byte (dos puntos)."""
    for fila in range(alto or 256):
        for j in range((ancho or 256) // 2):
            vram.escribe(pagina * 0x8000 + (y + fila) * G.ANCHO_DE_LINEA + (x >> 1) + j, byte)


def linea(vram, x, y, largo, color, vertical, pagina=0):
    """p00:469D (horizontal) y p00:46D0 (vertical): LINE de `largo` puntos."""
    for k in range(largo):
        if vertical:
            vram.pon_punto(pagina, x, y + k, color)
        else:
            vram.pon_punto(pagina, x + k, y, color)


def marco(vram, x, y, ancho, alto, color):
    """p00:4704: los cuatro lados de un rectangulo."""
    linea(vram, x, y, alto, color, True)
    linea(vram, x, y, ancho, color, False)
    linea(vram, x, y + alto - 1, ancho, color, False)
    linea(vram, x + ancho - 1, y, alto, color, True)


def letra(vram, c, x, y):
    """p00:491C: el caracter c del texto, un HMMM de 8x8 desde la pagina 1
    ((c % 32) * 8, 0x38 + (c / 32) * 8) a la 0; el 0 es el hueco (0, 0)."""
    if c:
        sx, sy = caracter_de(c)
        sy += 0x38
    else:
        sx = sy = 0
    G.hmmm(vram, sx, sy, x, y, 8, 8, 1, 0)


def rotulo(cart, bancos, hl, vram):
    """p00:48F3: [x][y] y caracteres; 0xFE trae otra posicion; 0xFF acaba. Los
    0x62 y 0x63 (el dakuten y el handakuten) solo avanzan 4 puntos."""
    x, y = cart.leer(hl, bancos), cart.leer(hl + 1, bancos)
    hl += 2
    while True:
        c = cart.leer(hl, bancos)
        hl += 1
        if c == 0xFF:
            return hl
        if c == 0xFE:
            x, y = cart.leer(hl, bancos), cart.leer(hl + 1, bancos)
            hl += 2
            continue
        letra(vram, c, x, y)
        x = (x + (4 if c in (0x62, 0x63) else 8)) & 0xFF


def sprites(vram, lista, colores, patrones=0xF800):
    """Los sprites de modo 2 del V9938: 16x16, un color por linea, ocho por
    linea como mucho (los de despues no salen) y la y una linea mas abajo.
    `lista` son (y, x, dibujo) y `colores` los 16 bytes de color de cada uno."""
    capa = {}
    por_linea = {}
    for k, (y, x, n) in enumerate(lista):
        if y == 0xD8:
            break
        for fila in range(16):
            yy = (y + 1 + fila) & 0xFF
            por_linea[yy] = por_linea.get(yy, 0) + 1
            if por_linea[yy] > 8:
                continue
            c = colores[k][fila] & 0x0F
            for mitad in range(2):
                b = vram.v[patrones + (n & 0xFC) * 8 + mitad * 16 + fila]
                for bit in range(8):
                    if b & (0x80 >> bit):
                        xx = x + mitad * 8 + bit
                        if xx < 256 and (xx, yy) not in capa:
                            capa[(xx, yy)] = c
    return capa


def konami(cart):
    v = G.Vram()
    G.pon_paleta(cart, S1, 0x6476, v)
    hmmv(v, 0x28, 0x40, 0xA8, 0x48, 0x00, 1)
    G.letras(G.de_la_rom(cart, S4, 0xBC92, 13 * 8), 0x08, 0x00, 13, 1, v)
    G.letras(G.de_la_rom(cart, S4, 0xBCFA, 13 * 8), 0x70, 0x00, 13, 2, v)
    G.letras(G.de_la_rom(cart, S4, 0xBD62, 26 * 8), 0xD8, 0x00, 26, 3, v)
    # p01:64A9: el cartel
    x0, y0, hl = 0x40, 0x40, 0x64C9
    x, y = x0, y0
    while True:
        c = cart.leer(hl, S1)
        hl += 1
        if c == 0xFF:
            break
        if c == 0xFE:
            d = cart.leer(hl, S1)
            hl += 1
            x0 = (x0 + d) & 0xFF
            y0 += 8
            x, y = x0, y0
            continue
        sx, sy = caracter_de(c)
        G.hmmm(v, sx, sy, x, y, 8, 8, 1, 1)
        x = (x + 8) & 0xFF
    # p01:6498: de la pagina 1 a la 0, hasta 0x30 lineas
    G.hmmm(v, 0x28, 0x40, 0x28, 0x40, 0xA8, 0x30, 1, 0)
    return v, 0x0F


def titulo(cart):
    v = G.Vram()
    # p00:4A6D: las letras y tres caracteres
    G.letras(G.de_la_rom(cart, S13, 0x929D, 0x91 * 8), 0x00, 0x40, 0x91, 0x0E, v)
    G.letras(G.de_la_rom(cart, S13, 0x9725, 10 * 8), 0x88, 0x60, 10, 0x03, v)
    G.sube_dibujos(G.de_la_rom(cart, S13, 0x9775, 3 * 32), 0xB06C, 3, v)
    # p00:4B91
    G.sube_dibujos(G.de_la_rom(cart, S4, 0xAE7C, 0x2E * 32), 0x8004, 0x2E, v)
    G.rle_a_la_vram(cart, S4, 0xF800, 0xB43C, v)
    G.pon_paleta(cart, G.S7, 0xA44E, v)
    # p00:5A9C: los caracteres del titulo
    hl = 0xB6B2
    for fila in range(12):
        for col in range(20):
            t = cart.leer(hl, S4)
            hl += 1
            sx, sy = caracter_de(t)
            G.hmmm(v, sx, sy, 0x30 + 8 * col, 0x20 + 8 * fila, 8, 8, 1, 0)
    # p00:5ABB: los sprites, y sus colores (0xEC00: 5 para los 7 primeros, 4)
    lista = [(cart.leer(0xB7A2 + 2 * k, S4), cart.leer(0xB7A3 + 2 * k, S4), 4 * k) for k in range(23)]
    colores = [[5] * 16 if k < 7 else [4] * 16 for k in range(23)]
    capa = sprites(v, lista, colores)
    # p00:5AF8: el marco y los rotulos
    marco(v, 0x44, 0x90, 0x74, 0x30, 0x0E)
    rotulo(cart, S1, 0x639B, v)
    return v, 0x00, capa


def imagen(v, fondo, capa=None, y0=0, alto=212):
    img = []
    for y in range(y0, y0 + alto):
        fila = []
        for x in range(256):
            c = v.punto(0, x, y)
            if capa and (x, y) in capa:
                c = capa[(x, y)]
            fila.append(G.rgb(v.paleta, c if c else fondo))
        img.append(fila)
    return img


def coteja():
    """La pagina 0 de lo dibujado contra la de los volcados: el logotipo en
    work/v_konami (tools/lanza_konami.sh, al acabar el barrido) y el titulo en
    work/v_demo/v02 (tools/lanza_vuelca.sh)."""
    cart = G.Cartucho()
    fallos = 0
    for nombre, (v, _fondo, *_), vol, zona in (
            ("konami", konami(cart), "../v_konami/konami", (0x28, 0x40, 0xA8, 0x30)),
            ("titulo", titulo(cart), "v02", (0, 0, 256, 212))):
        ruta = os.path.join(G.RAIZ, "work", "v_demo", vol + ".vram")
        d = open(ruta, "rb").read()
        x0, y0, an, al = zona
        dif = sum(1 for y in range(y0, y0 + al) for x in range(x0, x0 + an)
                  if v.punto(0, x, y) != ((d[y * 128 + x // 2] >> 4) if x % 2 == 0 else d[y * 128 + x // 2] & 15))
        print("%s contra %s: %d puntos distintos" % (nombre, vol, dif))
        fallos += dif != 0
    return fallos


def main():
    if sys.argv[1:] == ["coteja"]:
        sys.exit(1 if coteja() else 0)
    cart = G.Cartucho()
    v, fondo = konami(cart)
    print(G.guarda_png(imagen(v, fondo, y0=0x30, alto=0x48), os.path.join(G.RAIZ, "work", "konami.png"), escala=2))
    v, fondo, capa = titulo(cart)
    print(G.guarda_png(imagen(v, fondo, capa, y0=0, alto=0xC8), os.path.join(G.RAIZ, "work", "titulo.png"), escala=2))


if __name__ == "__main__":
    main()
