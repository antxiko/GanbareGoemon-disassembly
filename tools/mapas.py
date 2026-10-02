#!/usr/bin/env python3
"""El plano de cada zona, dibujado desde las tablas del cartucho, por calles.

Las casillas de una zona no caben en una rejilla: p00:4188 pone a cada casilla
la de antes a la izquierda y la de despues a la derecha, y la ficha de enlaces
(0xB7D0) cambia unos cuantos lados. Con eso salen CALLES -tiras de casillas
seguidas de izquierda a derecha- unidas por enlaces de arriba y abajo que no
son geometricos (en la zona 1-0, subir desde la 3 lleva a la 4, que tambien
esta a su derecha), y alguna calle que da la vuelta (la ultima casilla tiene a
la derecha la primera). Asi que aqui cada calle va en una fila, con la pantalla
de cada casilla montada por tools/graficos.py, su numero encima y, debajo, a
donde llevan sus enlaces de arriba y abajo.

Las cosas que se mueven (figuras) no se pintan: dependen de la partida. Las
fijas (0xA08E) si.

Uso: mapas.py [fase zona]   sin argumentos, todas las zonas distintas
"""
import os
import sys

from PIL import Image, ImageDraw

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import graficos as G  # noqa: E402

ALTO = G.FILAS * 8                    # 176 lineas de pantalla
MARGEN = 14                           # para el numero de casilla
PIE = 14                              # para los enlaces de arriba y abajo
HUECO = 10                            # entre calles


def calles(cart, z):
    """Las tiras de casillas seguidas por la derecha, en orden de casilla.
    Devuelve [(casillas, da_la_vuelta)]."""
    v = G.enlaces(cart, z)
    n = G.casillas(cart, z)
    puestas, fuera = set(), []

    def siguiente(i):
        d = v[i][G.DERECHA]
        if d is not None and d < n and v[d][G.IZQUIERDA] == i:
            return d
        return None
    for i in range(n):
        if i in puestas:
            continue
        # se empieza por una casilla sin vecina mutua a la izquierda; si la
        # tira es un anillo, por la mas baja
        a = v[i][G.IZQUIERDA]
        if a is not None and a < n and v[a][G.DERECHA] == i and a not in puestas:
            inicio, vistas = i, {i}
            while True:
                a = v[inicio][G.IZQUIERDA]
                if a is None or a >= n or v[a][G.DERECHA] != inicio or a in vistas:
                    break
                inicio = a
                vistas.add(a)
            if a in vistas and a is not None:
                inicio = min(vistas)
        else:
            inicio = i
        tira, c = [], inicio
        while c is not None and c not in puestas:
            tira.append(c)
            puestas.add(c)
            c = siguiente(c)
        fuera.append((tira, c is not None and c == tira[0]))
    return fuera


def dibuja(cart, z, ruta=None):
    v = G.enlaces(cart, z)
    tiras = calles(cart, z)
    ancho = max(len(t) for t, _ in tiras) * 256
    alto = len(tiras) * (MARGEN + ALTO + PIE + HUECO)
    img = Image.new("RGB", (ancho, alto), (24, 24, 24))
    dib = ImageDraw.Draw(img)
    vram = G.carga_la_zona(cart, z)
    y = 0
    for tira, anillo in tiras:
        for k, c in enumerate(tira):
            vv = G.Vram()
            vv.v[:] = vram.v
            vv.paleta = list(vram.paleta)
            cel = G.monta(cart, z, c)
            G.pinta(vv, cel)
            G.cosas_fijas(cart, z, c, vv, cel)
            foto = G.foto(vv)
            pant = Image.new("RGB", (256, ALTO))
            pant.putdata([p for fila in foto for p in fila])
            x = 256 * k
            img.paste(pant, (x, y + MARGEN))
            dib.text((x + 3, y + 1), "%d" % c, fill=(255, 255, 255))
            notas = []
            for lado, flecha in ((G.ARRIBA, "arriba"), (G.ABAJO, "abajo")):
                d = v[c][lado]
                if d is not None:
                    notas.append("%s %d" % (flecha, d))
            if notas:
                dib.text((x + 3, y + MARGEN + ALTO + 1), ", ".join(notas), fill=(255, 220, 120))
        if anillo:
            dib.text((256 * len(tira) - 60, y + 1), "vuelve a %d" % tira[0], fill=(120, 220, 255))
        y += MARGEN + ALTO + PIE + HUECO
    if ruta:
        img.save(ruta)
    return img


def distintas(cart):
    """Las zonas con datos distintos (varias fases repiten zona): una por
    (rejilla, enlaces, juego, cosas fijas)."""
    vistas, fuera = {}, []
    for z in range(G.FASES * G.ZONAS):
        clave = (cart.palabra(0x600C + 2 * z, G.S13), cart.palabra(0xB7D0 + 2 * z, G.S4),
                 G.juego_de_la_zona(cart, z), cart.palabra(0xA08E + 2 * z, G.S15))
        if clave in vistas:
            continue
        vistas[clave] = z
        fuera.append(z)
    return fuera


def main():
    cart = G.Cartucho()
    salida = os.path.join(G.RAIZ, "work", "mapas")
    os.makedirs(salida, exist_ok=True)
    if len(sys.argv) == 3:
        zs = [(int(sys.argv[1]) - 1) * G.ZONAS + int(sys.argv[2])]
    else:
        zs = distintas(cart)
    for z in zs:
        ruta = os.path.join(salida, "zona_%d_%d.png" % (z // G.ZONAS + 1, z % G.ZONAS))
        dibuja(cart, z, ruta)
        print(ruta)


if __name__ == "__main__":
    main()
