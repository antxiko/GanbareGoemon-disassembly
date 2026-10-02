#!/usr/bin/env python3
"""Las figuras de Ganbare Goemon (los enemigos y la gente), desde sus tablas.

LOS DIBUJOS (p00:5413). Cada tipo tiene una ficha de 10 bytes en 0xA830
(banco 12): [rle][VRAM][color 4 RB G][color 6 RB G][VRAM de la copia vuelta].
El rle de sus patrones de sprite va a la VRAM de [2-3] y, si [8] no es 0xFF, se
sube otra vez dado la vuelta a la de [8-9] (p00:54AB). Si [4] no es 0xFF, la
ficha pone los colores 4 y 6 de la paleta. Ocho tipos llevan un dibujo de mas
(0xA998: [tipo][rle][VRAM]).

LOS SPRITES (p02:87F2). La pose (ix+0x0A) apunta en 0xB6D2 a una ficha:
[desplazamientos] y el patron de cada sprite; los desplazamientos son
parejas [dy][dx] de la lista de 0xBAF3 (dx con signo). Cuantos sprites lleva
el tipo, 0x84B0 (p02:8355).

LOS COLORES (p00:54E6). Cada sprite lleva el color de la lista del tipo
(0x84DF, p02:8408) en sus 16 lineas; encima, la lista de su pose en 0x554E
(dos por tipo: el bit 0 de la pose elige el lado) con tripletes
[cuantas][desde][color], 0 acaba cada sprite.

LA POSE BASE (p03:AA04). Los tipos 1-0x21 la sacan de 0xAA51; pon_la_pose
(p02:893D) le suma 2 mirando al otro lado y p02:895B 1 en el paso de andar.

Uso:  enemigos.py           work/enemigos.png: cuatro poses por tipo
      enemigos.py coteja    cada figura de los volcados de work/v_zonas
"""
import glob
import os
import sys

from PIL import Image

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import graficos as G  # noqa: E402
import titulo as T  # noqa: E402

S1, S10 = G.S1, G.S10
TIPOS = range(1, 0x2F)            # 0x84B0: 47 entradas (1-0x2F); 0xA830 llega a 0x24


def ficha(cart, tipo):
    a = 0xA830 + (tipo - 1) * 10
    return [cart.leer(a + i, S10) for i in range(10)]


def carga_lo_del_interior(cart, v, jugador=1, interior=None):
    """p00:53E3: los patrones de las figuras de los interiores sin ficha
    (0x25-0x2F): 0xA783 (0xA7DD con el jugador 2, banco 12) a 0xF9C0 y 0x9F76
    (banco 14) a 0xFAC0."""
    G.rle_a_la_vram(cart, S10, 0xF9C0, 0xA783 if jugador == 1 else 0xA7DD, v)
    G.rle_a_la_vram(cart, G.S13, 0xFAC0, 0x9F76, v)
    if interior is not None:                          # p00:5409: la figura de 0x54B8
        t = cart.leer(cart.palabra(0x54B8 + 2 * interior, S1), S1)
        if t:
            carga_los_dibujos(cart, t, v)


def carga_los_dibujos(cart, tipo, v):
    """p00:542F con un solo tipo: sus patrones y sus colores 4 y 6."""
    if tipo > 0x24:
        carga_lo_del_interior(cart, v)
        return True
    for i in range(8):                                  # 0xA998
        a = 0xA998 + 5 * i
        if cart.leer(a, S10) == tipo:
            G.rle_a_la_vram(cart, S10, cart.palabra(a + 3, S10), cart.palabra(a + 1, S10), v)
    f = ficha(cart, tipo)
    rle, dest = f[0] | f[1] << 8, f[2] | f[3] << 8
    G.rle_a_la_vram(cart, S10, dest, rle, v)
    if f[4] != 0xFF:
        v.paleta[4] = ((f[4] >> 4) & 7, f[5] & 7, f[4] & 7)      # [RB][G], como p00:4666
        v.paleta[6] = ((f[6] >> 4) & 7, f[7] & 7, f[6] & 7)
    if f[8] != 0xFF:
        vuelto(cart, rle, f[8] | f[9] << 8, v)
    return True


def vuelto(cart, rle, dest, v):
    """p00:4562: el mismo rle con cada byte al reves y las dos columnas de cada
    sprite de 16x16 cambiadas (p00:4598)."""
    datos = []
    G.rle(cart, S10, rle, lambda nuevo, b: datos.append(b) if nuevo is None else None)
    out = bytearray(len(datos) + 32)
    pos, cuenta = 0x10, 0
    for b in datos:
        out[pos] = int("{:08b}".format(b)[::-1], 2)
        pos += 1
        cuenta += 1
        if cuenta % 32 == 0:
            pos += 0x20
        elif cuenta % 32 == 0x10:
            pos -= 0x20
    for i in range(len(datos)):
        v.v[dest + i] = out[i]


def sprites_de(cart, tipo, pose, y, x):
    """p02:87F2: (y, x, patron) de cada sprite."""
    n = cart.leer(0x84AF + tipo, S1)
    p = cart.palabra(0xB6D2 + 2 * pose, S10)
    desp = cart.palabra(0xBAF3 + 2 * cart.leer(p, S10), S10)
    lista = []
    for k in range(n):
        dy = cart.leer(desp + 2 * k, S10)
        dx = cart.leer(desp + 2 * k + 1, S10)
        if dx & 0x80:
            xx = x - ((-dx) & 0xFF)
            fuera = xx < 0
        else:
            xx = x + dx
            fuera = xx > 0xFF
        lista.append(((y + dy) & 0xFF if not fuera else 0xE1, xx & 0xFF, cart.leer(p + 1 + k, S10)))
    return lista


def colores_de(cart, juego_de_color, pose, n, base):
    """p00:54E6: 16 lineas del color base de cada sprite y la lista de la pose."""
    col = [[base[k]] * 16 for k in range(n)]
    if juego_de_color:
        de = cart.palabra(0x554E + 2 * ((juego_de_color - 1) * 2 + (pose & 1)), S1)
        for k in range(n):
            while True:
                c = cart.leer(de, S1)
                de += 1
                if c == 0:
                    break
                desde, color = cart.leer(de, S1), cart.leer(de + 1, S1)
                de += 2
                for f in range(desde, desde + c):
                    if f < 16:
                        col[k][f] = color
                    elif k + f // 16 < n:
                        col[k + f // 16][f % 16] = color
    return col


def colores_base(cart, tipo):
    n = cart.leer(0x84AF + tipo, S1)
    lista = cart.palabra(0x84DD + 2 * tipo, S1)
    return [cart.leer(lista + k, S1) for k in range(n)]


def pose_base(cart, tipo):
    return cart.leer(0xAA51 + (tipo - 1) * 4, (1, 2, 3)) if tipo <= 0x21 else None


def dibuja(cart, tipo, pose, y0=0x60, x0=0x80, v=None):
    if v is None:
        v = G.Vram()
        G.pon_paleta(cart, G.S7, 0xA3E6, v)
        G.pon_paleta(cart, G.S7, cart.palabra(0xA37A, G.S7), v)
    if not carga_los_dibujos(cart, tipo, v):
        return v, {}
    lista = sprites_de(cart, tipo, pose, y0, x0)
    col = colores_de(cart, tipo, pose, len(lista), colores_base(cart, tipo))
    return v, T.sprites(v, lista, col)


def hoja(cart, ruta):
    """Una fila por tipo 1-0x21: la pose base y las tres siguientes."""
    filas = []
    for t in range(1, 0x22):
        b = pose_base(cart, t)
        filas.append([dibuja(cart, t, b + k) for k in range(4)])
    celda = 48
    img = Image.new("RGB", (4 * celda, len(filas) * celda), (40, 40, 40))
    for i, fila in enumerate(filas):
        for k, (v, capa) in enumerate(fila):
            for (x, y), c in capa.items():
                xx, yy = k * celda + x - 0x80 + 16, i * celda + y - 0x60 + 16
                if 0 <= xx < 4 * celda and 0 <= yy < len(filas) * celda:
                    img.putpixel((xx, yy), G.rgb(v.paleta, c))
    img = img.resize((img.size[0] * 3, img.size[1] * 3), Image.NEAREST)
    img.save(ruta)
    return ruta


def coteja(ruta=os.path.join(G.RAIZ, "work", "v_zonas"), patron="z*.vram"):
    """Cada figura de 0xC600 en los volcados. La copia de 0xEE20 la rehace
    p01:685F en los cuadros impares y la figura se mueve en todos, asi que la
    copia puede ser de un cuadro antes: se busca la pose y el sitio que dan
    EXACTAMENTE lo que hay en ella (y, x y patron de cada sprite), y se miran
    sus patrones en la VRAM y sus 16 colores por sprite en 0xEC80."""
    cart = G.Cartucho()
    malos = vistos = otra = medias = 0
    for f in sorted(glob.glob(os.path.join(ruta, patron))):
        d = open(f, "rb").read()
        ram = open(f[:-5] + ".ram", "rb").read()
        for i in range(8):
            o = 0x600 + 0x80 * i
            tipo = ram[o]
            if not tipo or ram[o + 0x0E]:
                continue
            pose, n = ram[o + 0x0A], ram[o + 0x20]
            huecos = [ram[o + 0x21 + 5 * k] for k in range(n)]
            suyo = [tuple(ram[0x2E20 + 4 * h:0x2E23 + 4 * h]) for h in huecos]
            if any(y >= 0xE0 for y, _x, _p in suyo):
                continue                      # recien creada: aun sin sprites
            hallada = None
            for q in [pose] + [q for q in range(150) if q != pose]:
                prueba = sprites_de(cart, tipo, q, 0x80, 0x80)
                if prueba[0][0] == 0xE1:
                    continue
                y = (suyo[0][0] - prueba[0][0] + 0x80) & 0xFF
                x = suyo[0][1] - prueba[0][1] + 0x80
                if 0 <= x < 256 and sprites_de(cart, tipo, q, y, x) == suyo:
                    hallada = q
                    break
            mezcla = False
            if hallada is None:
                # el volcado a mitad de la copia: cada sprite de la pose o de
                # la anterior, en el mismo sitio
                for q in (pose, (pose - 1) & 0xFF):
                    ref = sprites_de(cart, tipo, q, 0x80, 0x80)
                    y = (suyo[0][0] - ref[0][0] + 0x80) & 0xFF
                    x = suyo[0][1] - ref[0][1] + 0x80
                    a1 = sprites_de(cart, tipo, pose, y, x)
                    a2 = sprites_de(cart, tipo, (pose - 1) & 0xFF, y, x)
                    if all(s in (p1, p2) for s, p1, p2 in zip(suyo, a1, a2)):
                        hallada, mezcla = pose, True
                        break
            v = G.Vram()
            if tipo > 0x24:
                carga_lo_del_interior(cart, v, interior=ram[0xD5F] if ram[0x482] else None)
            else:
                carga_los_dibujos(cart, tipo, v)
            dp = sum(1 for (_y, _x, p) in suyo for a in range(0xF800 + 8 * (p & 0xFC), 0xF800 + 8 * (p & 0xFC) + 32)
                     if v.v[a] != d[a])
            base = [ram[o + 0x25 + 5 * k] for k in range(n)]
            dc = min(sum(1 for k, h in enumerate(huecos) for fl in range(16)
                         if colores_de(cart, tipo, q, n, base)[k][fl] != ram[0x2C80 + 16 * h + fl])
                     for q in {pose, hallada if hallada is not None else pose})
            bien = hallada is not None and dp == 0 and dc == 0 and base == colores_base(cart, tipo)
            vistos += 1
            otra += hallada is not None and hallada != pose
            medias += mezcla
            malos += not bien
            if not bien:
                print("%s tipo 0x%02X pose 0x%02X: pose hallada %s, dibujos %d, colores %d"
                      % (os.path.basename(f), tipo, pose, hallada, dp, dc))
    print("%d figuras, %d distintas (%d con la pose de un cuadro antes, %d con la copia a medias)"
          % (vistos, malos, otra, medias))
    return malos


def main():
    if sys.argv[1:] == ["coteja"]:
        sys.exit(1 if coteja() else 0)
    print(hoja(G.Cartucho(), os.path.join(G.RAIZ, "work", "enemigos.png")))


if __name__ == "__main__":
    main()
