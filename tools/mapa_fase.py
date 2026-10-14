#!/usr/bin/env python3
"""El plano de cada fase: la pantalla de antes de entrar en la zona (el estado
4, paso 0, p00:5EFD), dibujada desde las tablas del cartucho.

  p00:4C26  los dibujos: 31 de 0xA7E0 (banco 6) desde 0x8004, 16 dados la
            vuelta de 0xA9C0 desde 0x8400, y los patrones de sprite del rle
            de 0xABC0 a 0xF800; la paleta, la base y la de 0xA476 (p00:4D54).
  p02:80D9  plano_de_la_fase: 3 filas de 28 caracteres de 0xA099 en la pagina 1
            desde y 0x10, que componen un dibujo de 32 x 24 por juego de
            graficos (x = juego * 32); marcos_de_la_fase: el rotulo 0x0C (las
            flechas) y dos marcos del color 0x0F; zonas_de_la_fase: el dibujo
            del juego de cada zona (0xB8EC, banco 9) en su punto (0x81C2,
            [y][x]) y el castillo, (0xC0, 0x10) de la pagina 1, en (0x50, 0x20).
  sprites   los tres del nombre de la provincia en (0x78, 0x48/0x60/0x78),
            con los patrones de 0x817D (tres por fase; un 0xFF no pone sprite y el siguiente
            va en su hueco, p02:8173) y el color
            0x0E; la marca de la zona (p02:8192): dos sprites en el punto de
            0xC280, patrones 0x3C y 0x38 (Goemon), colores 2 y 0x41 (el
            segundo con CC: se junta con OR). p02:823B la enciende y apaga cada
            8 cuadros.

Uso:  mapa_fase.py          docs/imagenes/plano_fase_1..7.gif (marca en la zona 0)
      mapa_fase.py coteja   contra work/v_mapa (tools/lanza_mapa.sh)
"""
import glob
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import graficos as G  # noqa: E402
import titulo as T  # noqa: E402

S1, S4, S7, S13 = G.S1, G.S4, G.S7, G.S13
S9 = (1, 2, 9)                           # p02:81F1: el banco 9 en 0xA000
S10 = G.S10
PUNTOS = 0x81C2
CUADROS_DEL_PARPADEO = 8                 # p02:823F


def vram_de_la_fase(cart, fase):
    v = G.Vram()
    # las letras siguen en la pagina 1 desde p00:4A6D (el rotulo las usa)
    G.letras(G.de_la_rom(cart, S13, 0x929D, 0x91 * 8), 0x00, 0x40, 0x91, 0x0E, v)
    G.letras(G.de_la_rom(cart, S13, 0x9725, 10 * 8), 0x88, 0x60, 10, 0x03, v)
    G.sube_dibujos(G.de_la_rom(cart, S13, 0x9775, 3 * 32), 0xB06C, 3, v)
    # p00:4C26
    G.sube_dibujos(G.de_la_rom(cart, S4, 0xA7E0, 31 * 32), 0x8004, 31, v)
    G.sube_dibujos_vueltos(G.de_la_rom(cart, S4, 0xA9C0, 16 * 32), 0x8400, 16, v)
    G.rle_a_la_vram(cart, S4, 0xF800, 0xABC0, v)
    # p00:4D54
    G.pon_paleta(cart, S7, 0xA3E6, v)
    G.pon_paleta(cart, S7, 0xA476, v)
    # p02:80EE: 3 filas de 28 caracteres, de la pagina 1 a la 1, desde y 0x10
    hl = 0xA099
    for fila in range(3):
        for col in range(28):
            sx, sy = T.caracter_de(cart.leer(hl, S1))
            hl += 1
            G.hmmm(v, sx, sy, col * 8, 0x10 + fila * 8, 8, 8, 1, 1)
    # p02:8123
    T.rotulo(cart, S10, cart.palabra(0xA9C0 + 2 * 0x0C, S10), v)   # p00:4284: el banco 12
    T.marco(v, 0x70, 0x40, 0x1F, 0x4F, 0x0F)
    T.marco(v, 0x72, 0x42, 0x1B, 0x4B, 0x0F)
    # p02:81F0
    for k in range(7):
        juego = cart.leer(0xB8EC + fase * 7 + k, S9)
        y, x = cart.leer(PUNTOS + 2 * k, S1), cart.leer(PUNTOS + 2 * k + 1, S1)
        G.hmmm(v, juego * 32, 0x10, x, y, 32, 24, 1, 0)
    G.hmmm(v, 0xC0, 0x10, 0x50, 0x20, 32, 24, 1, 0)
    return v


def sprites_de_la_fase(cart, fase, zona=0, marca=True):
    """La copia de 0xEE00 y de 0xEC00 como la dejan p02:813F-8170."""
    lista, colores = [], [[2] * 16, [0x41] * 16] + [[0x0E] * 16] * 3
    y, x = cart.leer(PUNTOS + 2 * zona, S1), cart.leer(PUNTOS + 2 * zona + 1, S1)
    for b in (2, 1):
        lista.append((y if marca else 0xE0, x, 0x34 + 4 * b))
    for k in range(3):
        n = cart.leer(0x817D + 3 * fase + k, S1)
        if n == 0xFF:                      # p02:8173: sin sprite, y el hueco se reaprovecha
            continue
        lista.append((cart.leer(0x8177 + 2 * k, S1), cart.leer(0x8178 + 2 * k, S1), n))
    return lista, colores[:len(lista)]


def capa(cart, v, fase, zona=0, marca=True):
    lista, colores = sprites_de_la_fase(cart, fase, zona, marca)
    return T.sprites(v, lista, colores)


def gif(cart, fase, ruta, escala=2):
    from PIL import Image
    v = vram_de_la_fase(cart, fase)
    cuadros = []
    for marca in (True, False):
        img = T.imagen(v, 0, capa(cart, v, fase, 0, marca))
        im = Image.new("RGB", (256, 212))
        im.putdata([p for fila in img for p in fila])
        cuadros.append(im.resize((256 * escala, 212 * escala), Image.NEAREST))
    ms = round(CUADROS_DEL_PARPADEO * 1000 / 60)
    cuadros[0].save(ruta, save_all=True, append_images=cuadros[1:], duration=[ms, ms], loop=0)
    return ruta


def coteja(ruta=os.path.join(G.RAIZ, "work", "v_mapa")):
    """Cada volcado fNN: la pagina 0, la paleta y los sprites de 0xEE00 de la
    RAM (los que estan en pantalla) contra lo dibujado."""
    cart = G.Cartucho()
    malos = 0
    for f in sorted(glob.glob(os.path.join(ruta, "f*.vram"))):
        ram = open(f[:-5] + ".ram", "rb").read()
        d = open(f, "rb").read()
        pal = open(f[:-5] + ".pal", "rb").read()
        fase, zona = ram[0x288], ram[0x280]
        v = vram_de_la_fase(cart, fase)
        puntos = sum(1 for y in range(212) for x in range(256)
                     if v.punto(0, x, y) != (d[y * 128 + x // 2] >> (4 * (1 - x % 2))) & 15)
        colores = [c for c in range(16) if c and v.paleta[c] != ((pal[2 * c] >> 4) & 7, pal[2 * c + 1] & 7, pal[2 * c] & 7)]
        lista, cols = sprites_de_la_fase(cart, fase, zona, ram[0x2E00] != 0xE0)
        suyos = [tuple(ram[0x2E00 + 4 * i:0x2E03 + 4 * i]) for i in range(len(lista))]
        suyos_c = [list(ram[0x2C00 + 16 * i:0x2C10 + 16 * i]) for i in range(len(lista))]
        # y que detras no haya mas visibles (y distinta de 0xE0 y de 0xD8) en los 5 huecos
        resto = [ram[0x2E00 + 4 * i] for i in range(len(lista), 5)]
        spr = suyos == lista and suyos_c == cols and all(y in (0xE0, 0xD8) for y in resto)
        bien = puntos == 0 and not colores and spr
        malos += not bien
        print("fase %d zona %d (%s): %d puntos distintos, colores distintos %s, sprites %s"
              % (fase + 1, zona, os.path.basename(f), puntos, colores or "ninguno", "iguales" if spr else "DISTINTOS"))
    return malos


def main():
    if sys.argv[1:] == ["coteja"]:
        return 1 if coteja() else 0
    cart = G.Cartucho()
    for fase in range(7):
        print(gif(cart, fase, os.path.join(G.IMAGENES, "plano_fase_%d.gif" % (fase + 1))))
    return 0


if __name__ == "__main__":
    sys.exit(main())
