#!/usr/bin/env python3
"""Coteja lo que dibuja tools/graficos.py con los volcados de openMSX.

Para cada volcado de work/<dir>/zNN.* (los hace tools/lanza_zonas.sh): monta la
pantalla de la casilla 0xC281 de la zona con los datos del cartucho y compara
(1) los caracteres de 0xD800 con la RAM volcada, (2) las 22 filas de la
pantalla (lineas 0x20-0xCF de la pagina 0) con la VRAM volcada, (3) los
caracteres de la pagina 1 que usa esa pantalla, y (4) la paleta, salvo los
colores 4 y 6, que ponen las fichas de figura (0xA830).

Uso: coteja.py [dir]      (por defecto work/v_zonas)
"""
import glob
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import graficos as G  # noqa: E402

FIGURAS = (4, 6)


def coteja(ruta):
    cart = G.Cartucho()
    malos = 0
    vistos = 0
    for f in sorted(glob.glob(os.path.join(ruta, "z*.vram"))):
        base = f[:-5]
        vram = open(f, "rb").read()
        pal = open(base + ".pal", "rb").read()
        ram = open(base + ".ram", "rb").read()
        fase, zona, casilla, sitio = ram[0x288], ram[0x280], ram[0x281], ram[0x267]
        z = fase * 7 + zona
        v = G.carga_la_zona(cart, z, sitio=sitio)
        cel = G.monta(cart, z, casilla)
        G.pinta(v, cel)
        G.cosas_fijas(cart, z, casilla, v, cel)
        d800 = ram[0x1800:0x1800 + 32 * 24]
        dc = sum(1 for r in range(G.FILAS) for c in range(32) if cel[r][c] != d800[r * 32 + c])
        dp = sum(1 for a in range(G.LINEA_DE_LA_PANTALLA * 128, (G.LINEA_DE_LA_PANTALLA + G.FILAS * 8) * 128)
                 if v.v[a] != vram[a])
        # en la pagina 1, solo los caracteres que usa la pantalla: el resto lo
        # puede haber pisado el juego despues (p02:80EE compone ahi el panel
        # de las tres filas de 0xA099)
        usados = set()
        for t in set(G.monta(cart, z, casilla)[r][c] for r in range(G.FILAS) for c in range(32)):
            for fila in range(8):
                base_t = 0x8000 + ((t >> 5) * 8 + fila) * 128 + (t & 0x1F) * 4
                usados.update(range(base_t, base_t + 4))
        d1 = sum(1 for a in usados if v.v[a] != vram[a])
        pv = [((pal[2 * i] >> 4) & 7, pal[2 * i + 1] & 7, pal[2 * i] & 7) for i in range(16)]
        dpal = [i for i in range(16) if i not in FIGURAS and pv[i] != v.paleta[i]]
        bien = not (dc or dp or d1 or dpal)
        malos += not bien
        vistos += 1
        print("%s  zona %d-%d casilla %3d sitio %d: 0xD800 %d, pantalla %d, pagina 1 %d, paleta %s  %s"
              % (os.path.basename(base), fase + 1, zona, casilla, sitio, dc, dp, d1, dpal or "-",
                 "OK" if bien else "DISTINTO"))
    print("%d volcados, %d distintos" % (vistos, malos))
    return 1 if malos or not vistos else 0


if __name__ == "__main__":
    sys.exit(coteja(sys.argv[1] if len(sys.argv) > 1 else os.path.join(G.RAIZ, "work", "v_zonas")))
