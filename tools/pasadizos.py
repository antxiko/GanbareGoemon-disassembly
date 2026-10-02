#!/usr/bin/env python3
"""Los pasadizos secretos de Ganbare Goemon, desde sus tablas.

DONDE. El interior 16 cobra por llevar a "el pasadizo secreto del fondo"
(rotulo 0x71). Al pagar pone 0xCDB0 = 1 (p03:B5B2), y con eso, de pie en x
0x30-0x50, y 0x40-0x46 y apretando arriba, p01:7D0D llama a p00:5969: se
entra en el pasadizo de la zona, que se recorre en primera persona. Que
zona tiene interior 16 lo dice la lista de puertas de cada zona (0x981D,
banco 14: [casilla][interior, bit 7 la segunda puerta], p00:53BA).

EL PASADIZO (p00:59A9). 0xA575 (banco 9) da por zona (fase x 7 + zona) una
ficha: [dibujo] y marcas. El dibujo, en 0xA86D: [alto][ancho] y las filas de
bits, (ancho + 7) / 8 bytes cada una, 1 pared y 0 paso; p00:59D7 lo pone en
0xD800 a un byte por casilla, 28 por fila. Las marcas son parejas
[lo que es << 5 | x][y] hasta un 0 (p00:5A10), salvo las ya cogidas (0xC290):
2 son 200 ryo, 3 una cosa 9 mas, 4 el mapa (0xC27A), 5 una vida y 6 la salida
(p03:BC5C). Se empieza en (1, 1) (p00:5A07).

EL MAPA (p03:BB1B). Con el mapa cogido, el primer boton lo ensena: cada
casilla es una pieza de 8 x 8 de la pagina 1 (0xBC1B: 1 pared, 2 y 3 sus
dibujos; 4 y 5 la pieza (0, 0)), centrado en la pantalla; la salida, en
blanco salvo con el bit 6 de 0xEF80 y la cosa 0x0A, que la ensenan con una
flecha hacia el lado abierto. El jugador, la pieza (0x60, 0x98) en su sitio
(p03:BBAA).

Uso:  pasadizos.py           work/pasadizos/mapa_F_Z.png, el mapa de cada uno
      pasadizos.py coteja    contra work/v_pasadizos (tools/lanza_pasadizos.sh)
"""
import glob
import os
import sys

from PIL import Image

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import graficos as G  # noqa: E402

S9 = (1, 2, 9)                          # p00:5972: el banco 9 en 0xA000
POR_FILA = 28                           # p00:59FF
PIEZAS = {1: (0x68, 0x98), 2: (0x68, 0x90), 3: (0x60, 0x90), 4: (0, 0), 5: (0, 0)}
JUGADOR = (0x60, 0x98)


def zonas_con_pasadizo(cart):
    """{zona: casilla del interior 16} por la lista de puertas de 0x981D."""
    fuera = {}
    for z in range(G.FASES * G.ZONAS):
        hl = cart.palabra(0x981D + 2 * z, G.S13)
        for k in range(cart.leer(hl, G.S13)):
            if cart.leer(hl + 2 + 2 * k, G.S13) & 0x7F == 16:
                fuera[z] = cart.leer(hl + 1 + 2 * k, G.S13)
    return fuera


def pasadizo(cart, z):
    """(dibujo, alto, ancho, rejilla[alto][ancho], marcas[(que, x, y)])."""
    ficha = cart.palabra(0xA575 + 2 * z, S9)
    dibujo = cart.leer(ficha, S9)
    p = cart.palabra(0xA86D + 2 * dibujo, S9)
    alto, ancho = cart.leer(p, S9), cart.leer(p + 1, S9)
    p += 2
    rejilla = []
    for _ in range(alto):
        bits = []
        for _k in range((ancho + 7) // 8):
            b = cart.leer(p, S9)
            p += 1
            bits += [(b >> (7 - i)) & 1 for i in range(8)]
        rejilla.append(bits[:ancho])
    marcas = []
    m = ficha + 1
    while cart.leer(m, S9):
        a, y = cart.leer(m, S9), cart.leer(m + 1, S9)
        marcas.append((a >> 5, a & 0x1F, y))
        rejilla[y][a & 0x1F] = a >> 5
        m += 2
    return dibujo, alto, ancho, rejilla, marcas


def esquina(alto, ancho):
    """p03:BB1B: y = (20 - alto) / 2 * 8 + 0x20, x = (28 - ancho) / 2 * 8 + 8."""
    return ((0x1C - ancho) // 2) * 8 + 8, ((0x14 - alto) // 2) * 8 + 0x20


def copia_caracter(v, sx, sy, dx, dy):
    """p00:4EF1: 8 x 8 de la pagina 1 a la 0, LMMM sin transparencia."""
    for y in range(8):
        for x in range(8):
            v.pon_punto(0, dx + x, dy + y, v.punto(1, sx + x, sy + y))


def mapa(cart, z, jugador=(1, 1)):
    """La pantalla del mapa del pasadizo de la zona z, como p03:BAF1 (sin el
    secreto del menu: la salida en blanco)."""
    v = G.Vram()
    G.carga_de_siempre(cart, v)
    # se entra desde la zona: el color 5 no lo ponen ni 0xA3E6 ni 0xA438
    G.pon_la_paleta(cart, G.juego_de_la_zona(cart, z), v)
    G.pon_paleta(cart, G.S7, 0xA3E6, v)                 # p00:4B76
    G.pon_paleta(cart, G.S7, 0xA438, v)                 # p00:4B7C
    _d, alto, ancho, rejilla, _m = pasadizo(cart, z)
    x0, y0 = esquina(alto, ancho)
    for y in range(alto):
        for x in range(ancho):
            c = rejilla[y][x]
            if c == 6:
                c = 4                                   # p03:BC15: la pieza (0, 0)
            if c:
                copia_caracter(v, *PIEZAS[c], x0 + 8 * x, y0 + 8 * y)
    copia_caracter(v, *JUGADOR, x0 + 8 * jugador[0], y0 + 8 * jugador[1])
    return v, (x0, y0, ancho * 8, alto * 8)


def imagen(cart, z, escala=2):
    v, (x0, y0, an, al) = mapa(cart, z)
    img = Image.new("RGB", (an, al))
    img.putdata([G.rgb(v.paleta, v.punto(0, x0 + x, y0 + y)) for y in range(al) for x in range(an)])
    return img.resize((an * escala, al * escala), Image.NEAREST)


def coteja(ruta=os.path.join(G.RAIZ, "work", "v_pasadizos")):
    """Cada volcado: la rejilla de 0xD800 (con el alto y el ancho de 0xCDD3 y
    0xCDD4) y, en el mapa, los puntos del recuadro y la paleta."""
    cart = G.Cartucho()
    malos = vistos = 0
    for f in sorted(glob.glob(os.path.join(ruta, "m*.vram"))):
        z = int(os.path.basename(f)[1:3])
        ram = open(f[:-5] + ".ram", "rb").read()
        d = open(f, "rb").read()
        pal = open(f[:-5] + ".pal", "rb").read()
        _dib, alto, ancho, rejilla, _m = pasadizo(cart, z)
        en_ram = [list(ram[0x1800 + POR_FILA * y:0x1800 + POR_FILA * y + ancho]) for y in range(alto)]
        v, (x0, y0, an, al) = mapa(cart, z, (ram[0xDC6], ram[0xDC7]))
        puntos = sum(1 for y in range(al) for x in range(an)
                     if v.punto(0, x0 + x, y0 + y) != (d[(y0 + y) * 128 + (x0 + x) // 2] >> (4 * (1 - (x0 + x) % 2))) & 15)
        colores = sum(1 for c in range(16)
                      if v.paleta[c] != ((pal[2 * c] >> 4) & 7, pal[2 * c + 1] & 7, pal[2 * c] & 7))
        bien = en_ram == rejilla and ram[0xDD3] == alto and ram[0xDD4] == ancho and puntos == 0 and colores == 0
        vistos += 1
        malos += not bien
        print("zona %d-%d: rejilla %s, %d puntos distintos, %d colores distintos"
              % (z // 7 + 1, z % 7, "igual" if en_ram == rejilla else "DISTINTA", puntos, colores))
    print("%d pasadizos, %d distintos" % (vistos, malos))
    return malos


def main():
    if sys.argv[1:] == ["coteja"]:
        sys.exit(1 if coteja() else 0)
    cart = G.Cartucho()
    salida = os.path.join(G.RAIZ, "work", "pasadizos")
    os.makedirs(salida, exist_ok=True)
    for z, casilla in sorted(zonas_con_pasadizo(cart).items()):
        ruta = os.path.join(salida, "mapa_%d_%d.png" % (z // 7 + 1, z % 7))
        imagen(cart, z).save(ruta)
        dib, alto, ancho, _r, marcas = pasadizo(cart, z)
        print("%s  interior 16 en la casilla %d, dibujo %d (%d x %d), marcas %s"
              % (ruta, casilla, dib, ancho, alto, " ".join("%d@%d,%d" % m for m in marcas)))


if __name__ == "__main__":
    main()
