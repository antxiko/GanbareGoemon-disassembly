#!/usr/bin/env python3
"""Los interiores de Ganbare Goemon, dibujados desde sus tablas.

Al entrar (p01:672F con 0xC482 = 1) p00:51ED monta la pantalla especial
(0x7239 con los bloques de 0x7269, banco 13) y p00:534E la pinta; p00:4D08
pone los colores de 0xA3FF encima de los de la zona. Luego p02:925D crea las
figuras del interior (ficha de 0x9567) y pinta su rotulo, y p02:94F7 las
cosas a la venta: el icono de cada una (p00:4EB9) en uno de los tres sitios
de 0x9556 y debajo su precio (cuatro cifras, p00:4420) con 両 detras.

Cada figura pone sus textos al nacer:
  0x25, la tienda (p03:AD39): si esta abierta (la cosa 0x0A, o la cifra de
        las decenas del tiempo impar en los interiores 0-7 y par en los 8-15)
        el texto 0xAEF1[n / 4]; si no, el rotulo 0x6F (0-7) o 0x70 (8-15)
  0x2B, la entrada al laberinto (p03:B551): rotulos 0 y 0x71, y el precio
        de la cosa 15 en (0x88, 0x38) (p03:B57F)
  0x24, los dados, y 0x28, la casa de cambio (p03:B16C, p03:B0FA): sin la
        cosa 0x0A, rotulos 0x18 y 0x1C (0x1D en la zona 6)
  0x2C, la posada (p03:B34F): rotulo 2
  0x2F, la casa de los consejos (p03:B6A4): el texto 0xB716[marca] y el
        rotulo 0
Los textos van por p03:B836: el rotulo 7 (borra), el 0x16 y el del texto.

Uso:  interiores.py           work/interiores/iNN.png
      interiores.py coteja    contra la pagina 0 de work/v_interiores
"""
import glob
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import graficos as G  # noqa: E402
import tiendas  # noqa: E402

S1, S7, S10, S13 = G.S1, G.S7, G.S10, G.S13
S3 = (1, 2, 3)


def letra(v, c, x, y):
    """p00:491C: la letra c de la pagina 1 en (x, y) de la 0 (HMMM, 8 x 8)."""
    if c:
        sx, sy = (c & 0x1F) * 8, (c >> 5) * 8 + 0x38
    else:
        sx = sy = 0
    G.hmmm(v, sx, sy, x, y, 8, 8, 1, 0)


def rotulo(cart, v, n):
    """p00:4280: el rotulo n (0xA9C0, banco 12)."""
    a = cart.palabra(0xA9C0 + 2 * n, S10)
    x, y = cart.leer(a, S10), cart.leer(a + 1, S10)
    a += 2
    while True:
        c = cart.leer(a, S10)
        a += 1
        if c == 0xFF:
            return
        if c == 0xFE:
            x, y = cart.leer(a, S10), cart.leer(a + 1, S10)
            a += 2
            continue
        letra(v, c, x, y)
        x = (x + (4 if c in (0x62, 0x63) else 8)) & 0xFF


def texto(cart, v, n):
    """p03:B836: borra (rotulos 7 y 0x16) y el texto n."""
    rotulo(cart, v, 7)
    rotulo(cart, v, 0x16)
    rotulo(cart, v, n)


def cifras_bcd(v, valor, x, y):
    """p00:4420 con B = 2: cuatro cifras, sin los ceros de delante."""
    s = "%04X" % valor
    pinta = False
    for i, d in enumerate(s):
        pinta = pinta or d != "0" or i >= 2
        letra(v, 0x20 + int(d) if pinta else 0, x, y)
        x += 8
    return x


def icono(cart, v, n, x, y):
    """p00:4EB9: el icono n de la pagina 1 (tabla 0x4EFC)."""
    sy, sx = cart.leer(0x4EFC + 2 * n, S1), cart.leer(0x4EFD + 2 * n, S1)
    t = 32 if n == 0x0E else 16
    G.hmmm(v, sx, sy, x, y, t, t, 1, 0)


def precio(cart, cosa, juego=0, avance=1, compras=0, c27e=0):
    """p02:92DA: el precio de la cosa, en BCD."""
    if not c27e and cosa >= 15:
        p = 0x900
    else:
        t = cart.palabra(0x9371 + 2 * ((juego & 1) + (juego >> 2)), S1)
        tramo = 0x60 if avance >= 0x28 else 0x40 if avance >= 0x14 else 0x20 if avance >= 0x0A else 0
        p = cart.palabra(t + tramo + 2 * (cosa - 1), S1)
    for _ in range(compras):
        p = min(int("%X" % p) * 2, 9999)
        p = int(str(p), 16)
    return p


def interior(cart, n, tiempo=0x98, zona=0, c27e=0):
    v = G.carga_la_zona(cart, zona)
    # las letras (p00:4A6D)
    G.letras(G.de_la_rom(cart, S13, 0x929D, 0x91 * 8), 0x00, 0x40, 0x91, 0x0E, v)
    G.letras(G.de_la_rom(cart, S13, 0x9725, 10 * 8), 0x88, 0x60, 10, 0x03, v)
    G.sube_dibujos(G.de_la_rom(cart, S13, 0x9775, 3 * 32), 0xB06C, 3, v)
    # la pantalla especial (p00:51FD)
    pantalla = G.de_la_rom(cart, S13, 0x7239, 48)
    bloques = G.de_la_rom(cart, S13, 0x7269, 16 * (max(pantalla) + 1))
    celdas = [[0] * 32 for _ in range(24)]
    for fb in range(6):
        for cb in range(8):
            b = pantalla[8 * fb + cb]
            for f in range(4):
                for c in range(4):
                    celdas[4 * fb + f][4 * cb + c] = bloques[16 * b + 4 * f + c]
    G.pinta(v, celdas)
    G.pon_paleta(cart, S7, 0xA3FF, v)
    _num, figs, cosas, rot = tiendas.interiores(cart)[n]
    for t in figs:
        if t == 0x25:
            abierta = c27e or (((n & 8) * 2) ^ (tiempo & 0x10))
            if abierta:
                texto(cart, v, cart.leer(0xAEF1 + (n >> 2), S3))
            else:
                rotulo(cart, v, 0x6F if n < 8 else 0x70)
        elif t == 0x2B:
            rotulo(cart, v, 0)
            rotulo(cart, v, 0x71)
            cifras_bcd(v, precio(cart, 15, c27e=c27e), 0x88, 0x38)
        elif t in (0x24, 0x28) and not c27e:
            rotulo(cart, v, 0x18)
            rotulo(cart, v, 0x1D if zona % 7 == 6 else 0x1C)
        elif t == 0x2C:
            rotulo(cart, v, 2)
        elif t == 0x2F and not c27e:
            texto(cart, v, cart.leer(0xB716 + 4, S3))
            rotulo(cart, v, 0)
    if rot != 0xFF:
        rotulo(cart, v, rot)
    # las cosas a la venta (p02:94F7)
    sitios = [(cart.leer(0x9556 + 2 * k, S1), cart.leer(0x9557 + 2 * k, S1)) for k in range(3)]
    vende = [c for c in cosas if c not in (15, 16)]
    for k, cosa in enumerate(vende):
        y, x = sitios[k]
        icono(cart, v, cosa - 1, x, y)
    for k, cosa in enumerate(vende):
        y, x = sitios[k]
        cifras_bcd(v, precio(cart, cosa), x - 0x10, y + 0x10)
        letra(v, 0x6A, x + 0x10, y + 0x10)
    return v


def coteja(ruta=os.path.join(G.RAIZ, "work", "v_interiores")):
    cart = G.Cartucho()
    malos = 0
    for f in sorted(glob.glob(os.path.join(ruta, "i*.vram"))):
        n = int(os.path.basename(f)[1:3])
        d = open(f, "rb").read()
        ram = open(f[:-5] + ".ram", "rb").read()
        v = interior(cart, n, tiempo=ram[0x4B0])
        dist = sum(1 for y in range(0x20, 0xD0) for x in range(0, 128)
                   if v.v[y * 128 + x] != d[y * 128 + x])
        print("interior %2d: %d bytes distintos" % (n, dist))
        malos += dist != 0
    return malos


def main():
    if sys.argv[1:] == ["coteja"]:
        sys.exit(1 if coteja() else 0)
    cart = G.Cartucho()
    for n in range(21):
        v = interior(cart, n, tiempo=0x90 if n < 8 else 0x80)   # la tienda abierta (p03:AD57)
        print(G.guarda_png(G.foto(v, y0=0x20, alto=0xB0), os.path.join(G.RAIZ, "work", "interiores", "i%02d.png" % n), 2))


if __name__ == "__main__":
    main()
