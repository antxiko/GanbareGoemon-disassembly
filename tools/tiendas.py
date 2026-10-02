#!/usr/bin/env python3
"""Las tiendas y los demas interiores, leidos de la ROM.

LOS INTERIORES (p02:925D). Al entrar por una puerta, su numero (0-20) elige
en 0x9567 una ficha: los tipos de figura que hay dentro, hasta un 0; dos
bytes con un bit por cosa a la venta (el de arriba, la cosa 1; p02:92C4) y el
rotulo (0xFF, ninguno).

LOS PRECIOS (p02:932A). Tres tablas (0x9371), por la clase de tienda: el
juego de graficos de la zona, (juego mod 2) + juego / 4. Cada una, cuatro
tramos de 16 precios en BCD segun lo avanzado (fase * 7 + zona + 1: hasta 9,
10-19, 20-39, 40 o mas). Sin la cosa 0x0A, las cosas 15 y 16 cuestan 900
(p02:92E3). Cada compra de lo mismo en la zona DOBLA el precio (p02:930C).

LO QUE HACE CADA COMPRA (p03:ADE5, tabla de 0xADEB): la cosa n es la n - 1 del
marcador (0xC270 + n - 1).

Uso: tiendas.py      escribe work/tiendas.txt
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import graficos as G  # noqa: E402

S1, S3 = G.S1, (1, 2, 3)
QUE_HACE = {
    0xAE07: "una mas de la cosa (hasta 3)",
    0xAE98: "la cosa vale 1",
    0xAEA3: "la cosa vale 5 (cinco golpes)",
    0xAE93: "la cosa 8, 100 segundos",
    0xAEAE: "16 de vida",
    0xAEB0: "8 de vida",
    0xAEC4: "200 segundos mas",
}


def interiores(cart):
    out = []
    for k in range(21):
        a = cart.palabra(0x9567 + 2 * k, S1)
        figs = []
        while cart.leer(a, S1):
            figs.append(cart.leer(a, S1))
            a += 1
        a += 1
        mascara = cart.leer(a, S1) | cart.leer(a + 1, S1) << 8
        rotulo = cart.leer(a + 2, S1)
        cosas = [n + 1 for n in range(16) if mascara & (0x8000 >> n)]
        out.append((k, figs, cosas, rotulo))
    return out


def precios(cart):
    tablas = []
    for c in range(3):
        t = cart.palabra(0x9371 + 2 * c, S1)
        tramos = []
        for tramo in range(4):
            fila = []
            for n in range(16):
                a = t + tramo * 0x20 + 2 * n
                fila.append("%X%02X" % (cart.leer(a + 1, S1), cart.leer(a, S1)))
            tramos.append([int(x) for x in fila])
        tablas.append(tramos)
    return tablas


def compras(cart):
    return [cart.palabra(0xADEB + 2 * i, S3) for i in range(14)]


def main():
    cart = G.Cartucho()
    lineas = ["INTERIORES (0x9567): numero, figuras, cosas a la venta, rotulo"]
    for k, figs, cosas, rot in interiores(cart):
        lineas.append("%2d  figuras %-24s cosas %-20s rotulo %s" % (
            k, " ".join("0x%02X" % f for f in figs), " ".join(map(str, cosas)) or "-",
            "-" if rot == 0xFF else "0x%02X" % rot))
    lineas.append("")
    lineas.append("PRECIOS (0x9371), en ryo: clase, tramo, cosas 1-16")
    for c, tramos in enumerate(precios(cart)):
        for t, fila in enumerate(tramos):
            lineas.append("clase %d tramo %d: %s" % (c, t, " ".join("%4d" % p for p in fila)))
    lineas.append("")
    lineas.append("LO QUE HACE CADA COMPRA (0xADEB)")
    for i, d in enumerate(compras(cart)):
        lineas.append("cosa %2d -> marcador %d: 0x%04X %s" % (i + 1, i, d, QUE_HACE.get(d, "?")))
    ruta = os.path.join(G.RAIZ, "work", "tiendas.txt")
    open(ruta, "w", encoding="utf-8", newline="\n").write("\n".join(lineas) + "\n")
    print("\n".join(lineas))


if __name__ == "__main__":
    main()
