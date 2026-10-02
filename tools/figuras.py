#!/usr/bin/env python3
"""Las figuras de Ganbare Goemon, dibujadas desde las tablas del cartucho.

EL JUGADOR (p00:4CAB y p01:74A6). Hay 20 poses: 0xC49F x 4 + 0xC4A2 (lo que
hace por el lado al que mira). Por cada una, p00:4CCE sube a 0xF800 los
dibujos de sus sprites, en rle, de la tabla 0x9319 (jugador 1) o 0x9341
(jugador 2), y p01:74CD pone los sprites de la lista de 0xAA56 (o 0xAA7E):
[n] y n parejas [dy][dx] sobre la posicion del jugador (0xC498, 0xC49A), el
sprite k con el dibujo 4 x k. Los colores los pone p01:7538 en 0xEC00, 16 por
sprite: los dos primeros del color 2, el tercero del 1, el cuarto del 3 (del
0x0E con 0xC271 puesto; el jugador 2, del 2 o del 3), y si hay quinto y sexto
(0xEC40), mitad del 2 y mitad del 8 (0x0E el jugador 2), con dos lineas del 7
segun el lado (0x75E0).

Uso:  figuras.py            escribe work/goemon.png y work/ebisumaru.png
      figuras.py coteja     coteja la pose de los volcados de work/v_zonas
"""
import os
import sys

from PIL import Image

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import graficos as G  # noqa: E402
import titulo as T  # noqa: E402

S7, S9 = G.S7, (7, 8, 9)


def colores_del_jugador(jugador, lado, c271=0, c4ae=0):
    """p01:7538 con 0xC490 < 2, 0xC492 = 0: los 16 colores de cada uno de los
    seis sprites que puede llevar el jugador. Con 0xC4AE puesto (p01:705C lo
    pone con la accion 4) todos parpadean entre el 0x0E y el 2 (p01:7575):
    aqui, el 0x0E."""
    if c4ae:
        return [[0x0E] * 16 for _ in range(7)]
    if jugador == 1:
        cuarto = 0x03 if c271 == 0 else 0x0E
        quinto = 0x08
    else:
        cuarto = 0x02 if c271 == 0 else 0x03
        quinto = 0x0E
    col = [[2] * 16, [2] * 16, [1] * 16, [cuarto] * 16, [2] * 16, [quinto] * 16]
    marca = [0, 6, 10, 10][lado]                  # 0x75E0 por 0xC4A2
    if marca and jugador == 1:
        k = 0x40 + marca                         # p01:75C9: 0xEC50 + marca
        s, f = divmod(k, 16)
        col[s][f] = col[s][f + 1] = 7
    col.append([2] * 16)                         # 0xEC60
    return col


def pose_del_jugador(cart, jugador, k):
    """Los sprites (dy, dx, dibujo) de la pose k y el rle de sus dibujos."""
    tabla = 0xAA56 if jugador == 1 else 0xAA7E
    a = cart.palabra(tabla + 2 * k, S9)
    n = cart.leer(a, S9)
    lista = []
    for i in range(n):
        dy = cart.leer(a + 1 + 2 * i, S9)
        dx = cart.leer(a + 2 + 2 * i, S9)
        lista.append((dy, dx, 4 * i))
    rle = cart.palabra((0x9319 if jugador == 1 else 0x9341) + 2 * k, S7)
    return lista, rle


def dibuja_pose(cart, jugador, k, y0=0x70, x0=0x80):
    v = G.Vram()
    G.pon_paleta(cart, S7, 0xA3E6, v)
    G.pon_paleta(cart, S7, cart.palabra(0xA37A, S7), v)
    lista, rle = pose_del_jugador(cart, jugador, k)
    G.rle_a_la_vram(cart, S7, 0xF800, rle, v)
    col = colores_del_jugador(jugador, k % 4, c4ae=1 if k >= 16 else 0)
    sprites = [((y0 + dy) & 0xFF, (x0 + dx) & 0xFF, n) for dy, dx, n in lista]
    capa = T.sprites(v, sprites, col[:len(sprites)])
    return v, capa, sprites


def hoja(cart, jugador, ruta):
    """Las 20 poses: una columna por accion (0xC49F) y una fila por lado
    (0xC4A2)."""
    poses = [dibuja_pose(cart, jugador, k) for k in range(20)]
    xs = [x for _, capa, _ in poses for (x, _y) in capa]
    ys = [y for _, capa, _ in poses for (_x, y) in capa]
    x0, y0 = min(xs) - 4, min(ys) - 4
    celda_x, celda_y = max(xs) - x0 + 5, max(ys) - y0 + 5
    img = Image.new("RGB", (5 * celda_x, 4 * celda_y), (40, 40, 40))
    for k, (v, capa, _) in enumerate(poses):
        for (x, y), c in capa.items():
            img.putpixel(((k // 4) * celda_x + x - x0, (k % 4) * celda_y + y - y0), G.rgb(v.paleta, c))
    img = img.resize((img.size[0] * 3, img.size[1] * 3), Image.NEAREST)
    img.save(ruta)
    return ruta


def coteja(ruta=os.path.join(G.RAIZ, "work", "v_zonas")):
    """La pose del volcado: los dibujos de 0xF800 y la lista de 0xEE00."""
    import glob
    cart = G.Cartucho()
    malos = 0
    for f in sorted(glob.glob(os.path.join(ruta, "z*.vram")))[:5]:
        d = open(f, "rb").read()
        ram = open(f[:-5] + ".ram", "rb").read()
        jugador = 2 if ram[0x002] & 0x80 else 1
        k = ram[0x49F] * 4 + ram[0x4A2]
        lista, rle = pose_del_jugador(cart, jugador, k)
        v = G.Vram()
        G.rle_a_la_vram(cart, S7, 0xF800, rle, v)
        dp = sum(1 for a in range(0xF800, 0xF800 + 32 * len(lista)) if v.v[a] != d[a])
        y, x = ram[0x498], ram[0x49A]
        ee = [(ram[0x2E00 + 4 * i], ram[0x2E01 + 4 * i], ram[0x2E02 + 4 * i]) for i in range(len(lista))]
        mio = [((y + dy) & 0xFF, (x + dx) & 0xFF, n) for dy, dx, n in lista]
        col = colores_del_jugador(jugador, ram[0x4A2])
        dc = sum(1 for i in range(len(lista)) for f2 in range(16) if col[i][f2] != ram[0x2C00 + 16 * i + f2])
        bien = dp == 0 and ee == mio and dc == 0
        malos += not bien
        print("%s jugador %d pose %d: dibujos %d, sprites %s, colores %d  %s"
              % (os.path.basename(f), jugador, k, dp, "iguales" if ee == mio else "%s / %s" % (ee, mio),
                 dc, "OK" if bien else "DISTINTO"))
    return malos


def main():
    if sys.argv[1:] == ["coteja"]:
        sys.exit(1 if coteja() else 0)
    cart = G.Cartucho()
    print(hoja(cart, 1, os.path.join(G.RAIZ, "work", "goemon.png")))
    print(hoja(cart, 2, os.path.join(G.RAIZ, "work", "ebisumaru.png")))


if __name__ == "__main__":
    main()
