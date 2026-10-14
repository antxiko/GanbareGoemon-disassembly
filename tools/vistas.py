#!/usr/bin/env python3
"""La vista en primera persona de los pasadizos secretos, desde sus tablas.

LO QUE SE VE (p03:B936). Desde la casilla 0xCDC6 (x, y) mirando hacia 0xCDC4
(0 arriba, 1 derecha, 2 abajo, 3 izquierda; pasos de 0xBAD9):
  delante   lo_de_delante (p03:B955) mira hasta 4 casillas: 0xCDB2 = a cuantas
            esta la pared (1) o la salida (6, una mas alla; 5 es 0), y 0 si no
            hay en 4. Con salida delante, o de pie en una con paso detras,
            0xCDCC = 1. Lo que hay en las tres primeras (2-5) va a 0xCDC9.
  los lados p03:BA47 y p03:BA62: desde la casilla de la izquierda (0xBAE1) o la
            de la derecha (0xBAE9), tantas hacia delante como 0xCDB2 (4 si es
            0). Cada una da un dibujo: pared C (izquierda 5-8, derecha 0x11-
            0x14, por profundidad), hueco C + 4 y, el hueco justo antes de la
            pared de delante, la esquina C + 8 (p03:BAA5).
LA PINTADA (p02:98BE). Los ocho dibujos de los lados y luego el de delante:
0xCDB2 (con salida, 0x1C mas). Cada dibujo (0xB91D, banco 9) es [ancho][y][x]
y 14 filas de caracteres de la pagina 1, copiados de 8 en 8 sin
transparencia (p00:4EF1). Los caracteres los sube p00:4B5D: 59 desde 0x8004
y 37 dados la vuelta desde 0x8800 (banco 7), con la paleta base y la de
0xA438.
ALREDEDOR (p03:B843). El marco: dos columnas de 14 caracteres en x 0x40 y
0xC8 y dos filas de 16 en y 0x28 y 0xA0; las cuatro esquinas y la rosa de
la derecha (0xB882, [y][x][y][x]).
LOS SPRITES. La flecha (p03:B9CB) en (0xD8, 0x30): a los lados, los dibujos
0xEC y 0xF0 con los colores 0x0C y 0x03 (al reves segun el lado); arriba o
abajo, el 0xE8 con 8 lineas de cada color. Lo de delante (p02:98E3): por
cosa (2-5) y distancia (0-2), la ficha de 0x9953: [y][x], el primer sprite
y [n] parejas [dibujo][color]. Los dibujos, del rle de 0x84AA (banco 11) a
0xF9C0 (p00:4B85).

Uso:  vistas.py          docs/imagenes/vista_F_Z.gif (el recorrido) y vistas_piezas.png
      vistas.py pasos Z  los movimientos del recorrido de la zona Z (sin el de salir)
      vistas.py coteja   contra work/v_pasadizos (tools/lanza_pasadizos.sh), z80run y
                         work/v_recorrido (tools/lanza_recorrido.sh)
"""
import glob
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import graficos as G  # noqa: E402
import pasadizos as P  # noqa: E402
import titulo as T  # noqa: E402

S2 = G.S1                                   # p02:9904: el banco 2 en 0x8000
S3 = G.S1
S9 = P.S9
PASO = ((0, -1), (1, 0), (0, 1), (-1, 0))   # 0xBAD9
IZQUIERDA = ((-1, 0), (0, -1), (1, 0), (0, 1))  # 0xBAE1
DERECHA = ((1, 0), (0, 1), (-1, 0), (0, -1))    # 0xBAE9
RECORTE = (0x40, 0x28, 0xB0, 0x80)          # el marco y la rosa: x, y, ancho, alto
ESCALA = 2


def casilla(rejilla, x, y):
    """p00:5A6A: 0xD800 + y * 28 + x; fuera del dibujo, 0."""
    if 0 <= y < len(rejilla) and 0 <= x < len(rejilla[0]):
        return rejilla[y][x]
    return 0


def lo_que_se_ve(rejilla, x, y, d):
    """p03:B936: dict(cdb2, cdcc, cdb3[8], cdbb[8], cdc9[3])."""
    v = dict(cdb2=0, cdcc=0, cdb3=[0] * 8, cdbb=[0] * 8, cdc9=[0] * 3)
    if casilla(rejilla, x, y) == 6:                         # p03:B9AB
        dx, dy = PASO[(d + 2) & 3]
        if casilla(rejilla, x + dx, y + dy) != 1:
            v["cdcc"] = 1
    dx, dy = PASO[d]
    hx, hy, c = x, y, 1
    for _ in range(4):
        hx, hy = (hx + dx) & 0xFF, (hy + dy) & 0xFF
        a = casilla(rejilla, hx, hy)
        if a == 1:
            break
        if a == 6:                                          # p03:B99C
            c += 1
            if c == 5:
                c = 0
            v["cdcc"] = 1
            break
        if a and c != 4:                                    # p03:BA33
            v["cdc9"][c - 1] = a
        c += 1
    else:
        c = 0
    v["cdb2"] = c
    for lado, c0, k0 in ((IZQUIERDA, 5, 0), (DERECHA, 0x11, 4)):
        sx, sy = lado[d]
        hx, hy = (x + sx) & 0xFF, (y + sy) & 0xFF
        c = c0
        for k in range(v["cdb2"] or 4):
            a = casilla(rejilla, hx, hy)
            n = c if a == 1 else c + 4                      # p03:BAA5
            if a != 1 and ((n - 1) & 3) == ((v["cdb2"] - 1) & 0xFF):
                n += 4
            v["cdb3"][k0 + k] = a
            v["cdbb"][k0 + k] = n
            hx, hy = (hx + dx) & 0xFF, (hy + dy) & 0xFF
            c += 1
    return v


def dibujos(v):
    """p02:98BE: los dibujos en el orden en que se pintan."""
    out = [n for n in v["cdbb"] if n]
    out.append(v["cdb2"] + (0x1C if v["cdb2"] and v["cdcc"] else 0))
    return out


def vram_del_pasadizo(cart, z):
    """La zona cargada (de donde se entra) y encima p00:4B5D."""
    vr = G.carga_la_zona(cart, z)
    G.sube_dibujos(G.de_la_rom(cart, G.S7, 0x6820, 0x3B * 32), 0x8004, 0x3B, vr)
    G.sube_dibujos_vueltos(G.de_la_rom(cart, G.S7, 0x6AC0, 0x25 * 32), 0x8800, 0x25, vr)
    G.pon_paleta(cart, G.S7, 0xA3E6, vr)
    G.pon_paleta(cart, G.S7, 0xA438, vr)
    G.rle_a_la_vram(cart, G.S10, 0xF9C0, 0x84AA, vr)
    return vr


def pinta_dibujo(cart, vr, n):
    """p02:99FB."""
    p = cart.palabra(0xB91D + 2 * n, S9)
    ancho, y, x = cart.leer(p, S9), cart.leer(p + 1, S9), cart.leer(p + 2, S9)
    p += 3
    for fila in range(14):
        for col in range(ancho):
            t = cart.leer(p, S9)
            p += 1
            P.copia_caracter(vr, (t % 32) * 8, (t // 32) * 8, x + 8 * col, y + 8 * fila)


def marco(cart, vr):
    """p03:B843."""
    for k in range(14):
        P.copia_caracter(vr, 0xA0, 0x08, 0x40, 0x30 + 8 * k)
        P.copia_caracter(vr, 0xF0, 0x10, 0xC8, 0x30 + 8 * k)
    for k in range(16):
        P.copia_caracter(vr, 0x78, 0x00, 0x48 + 8 * k, 0x28)
        P.copia_caracter(vr, 0x70, 0x00, 0x48 + 8 * k, 0xA0)
    for k in range(8):
        dy, dx, sy, sx = (cart.leer(0xB882 + 4 * k + j, S3) for j in range(4))
        P.copia_caracter(vr, sx, sy, dx, dy)


def sprites(cart, v, d):
    """La copia de 0xEE00 (y, x, dibujo) y de 0xEC00 (colores) de la flecha y
    de lo de delante; los demas, escondidos (y = 0xE0)."""
    lista = [[0xE0, 0, 0] for _ in range(32)]
    colores = [[0] * 16 for _ in range(32)]
    if d & 1:                                               # p03:B9D2
        c1, c2 = (0x03, 0x0C) if d & 2 else (0x0C, 0x03)
        lista[0], lista[1] = [0x30, 0xD8, 0xEC], [0x30, 0xD8, 0xF0]
        colores[0], colores[1] = [c1] * 16, [c2] * 16
    else:                                                   # p03:BA09
        e, dd = (0x0C, 0x03) if d & 2 else (0x03, 0x0C)
        lista[0] = [0x30, 0xD8, 0xE8]
        colores[0] = [e] * 8 + [dd] * 8
    for c, a in enumerate(v["cdc9"]):                       # p02:98E3
        if a in (0, 1, 6):
            continue
        t = cart.palabra(0x9953 + 2 * (a - 2), S2)
        f = cart.palabra(t + 2 * c, S2)
        y, x, k, n = (cart.leer(f + j, S2) for j in range(4))
        for i in range(n):
            lista[k // 4] = [y, x, cart.leer(f + 4 + 2 * i, S2)]
            colores[k // 4] = [cart.leer(f + 5 + 2 * i, S2)] * 16
            k += 4
    return [tuple(s) for s in lista], colores


def pantalla(cart, z, x=1, y=1, d=0, vr=None):
    """La vista entera: (vram, capa de sprites, lo_que_se_ve)."""
    vr = vr or vram_del_pasadizo(cart, z)
    rejilla = P.pasadizo(cart, z)[3]
    v = lo_que_se_ve(rejilla, x, y, d)
    for n in dibujos(v):
        pinta_dibujo(cart, vr, n)
    marco(cart, vr)
    lista, colores = sprites(cart, v, d)
    return vr, T.sprites(vr, lista, colores), v


def mueve(rejilla, x, y, d, accion):
    """p03:B8C3: 'A' avanza (no con pared justo delante; con salida delante y
    la pared pegada, se sale: devuelve None), 'I'/'D' giran, 'V' media vuelta.
    Al pisar una cosa (2-5) se coge y la casilla queda a 0 (p03:BC5C)."""
    if accion == "I":
        return x, y, (d - 1) & 3
    if accion == "D":
        return x, y, (d + 1) & 3
    if accion == "V":
        return x, y, (d + 2) & 3
    v = lo_que_se_ve(rejilla, x, y, d)
    if v["cdb2"] == 1:
        return None if v["cdcc"] else (x, y, d)
    dx, dy = PASO[d]
    x, y = x + dx, y + dy
    if casilla(rejilla, x, y) in (2, 3, 4, 5):
        rejilla[y][x] = 0
    return x, y, d


def _camino(rejilla, ini, meta):
    """Lo mas corto (en movimientos) de ini a un estado que cumpla meta; la
    meta None es salir. Las cosas del camino no se miran (se pisan igual)."""
    from collections import deque
    previo = {ini: None}
    cola = deque([ini])
    while cola:
        e = cola.popleft()
        for a in "AIDV":
            copia = [fila[:] for fila in rejilla]
            n = mueve(copia, *e, a)
            if n is None:
                if meta is None:
                    pasos = [a]
                    while previo[e]:
                        e, a0 = previo[e]
                        pasos.append(a0)
                    return pasos[::-1]
                continue
            if n in previo:
                continue
            previo[n] = (e, a)
            if meta is not None and meta(n):
                pasos = []
                while previo[n]:
                    n, a0 = previo[n]
                    pasos.append(a0)
                return pasos[::-1]
            cola.append(n)
    return None


def recorrido(cart, z):
    """Desde (1, 1) mirando 0xCDC4 = 0: a por la cosa mas cercana hasta que no
    quede ninguna a la que se llegue, y luego a la salida. Devuelve los
    movimientos y los estados (x, y, d, rejilla) de cada cuadro."""
    rejilla = [fila[:] for fila in P.pasadizo(cart, z)[3]]
    e = (1, 1, 0)
    acciones, estados = [], [(e, [f[:] for f in rejilla])]
    while True:
        pasos = _camino(rejilla, e, lambda n: casilla(rejilla, n[0], n[1]) in (2, 3, 4, 5))
        if not pasos:
            break
        for a in pasos:
            e = mueve(rejilla, *e, a)
            acciones.append(a)
            estados.append((e, [f[:] for f in rejilla]))
    pasos = _camino(rejilla, e, None)
    for a in pasos[:-1]:
        e = mueve(rejilla, *e, a)
        acciones.append(a)
        estados.append((e, [f[:] for f in rejilla]))
    acciones.append(pasos[-1])
    return acciones, estados


def gif(cart, z, ruta, ms=250, final=1500):
    """Un cuadro por movimiento (el ritmo es del jugador: 250 ms es nuestro)."""
    base = vram_del_pasadizo(cart, z)
    _a, estados = recorrido(cart, z)
    cuadros = []
    for (x, y, d), rejilla in estados:
        vr = G.Vram()
        vr.v[:] = base.v
        vr.paleta = list(base.paleta)
        v = lo_que_se_ve(rejilla, x, y, d)
        for n in dibujos(v):
            pinta_dibujo(cart, vr, n)
        marco(cart, vr)
        lista, colores = sprites(cart, v, d)
        cuadros.append(imagen(vr, T.sprites(vr, lista, colores)))
    duraciones = [ms] * (len(cuadros) - 1) + [final]
    cuadros[0].save(ruta, save_all=True, append_images=cuadros[1:], duration=duraciones, loop=0)
    return len(cuadros)


FILAS_DE_PIEZAS = ((0, 1, 2, 3, 4, 0x1D, 0x1E, 0x1F, 0x20),        # delante y la salida
                   tuple(range(5, 17)), tuple(range(0x11, 0x1D)))  # izquierda, derecha


def piezas(cart, ruta, escala=1):
    """Las 33 piezas de 0xB91D, cada una sola dentro del marco, con su numero."""
    from PIL import Image, ImageDraw
    base = vram_del_pasadizo(cart, 0)
    x0, y0, an, al = 0x40, 0x28, 0x90, 0x80
    hueco = 14
    hoja = Image.new("RGB", (12 * (an + 6) * escala, 3 * (al + hueco + 6) * escala), (0, 0, 0))
    dib = ImageDraw.Draw(hoja)
    for fila, ns in enumerate(FILAS_DE_PIEZAS):
        for col, n in enumerate(ns):
            vr = G.Vram()
            vr.v[:] = base.v
            vr.paleta = list(base.paleta)
            pinta_dibujo(cart, vr, n)
            marco(cart, vr)
            img = imagen(vr, {}, (x0, y0, an, al), escala)
            px, py = col * (an + 6) * escala, fila * (al + hueco + 6) * escala
            dib.text((px + 2, py), "0x%02X" % n, fill=(255, 255, 255))
            hoja.paste(img, (px, py + hueco * escala))
    hoja.save(ruta)
    return ruta


def imagen(vr, capa, recorte=RECORTE, escala=ESCALA):
    from PIL import Image
    x0, y0, an, al = recorte
    img = Image.new("RGB", (an, al))
    img.putdata([G.rgb(vr.paleta, capa.get((x0 + x, y0 + y), vr.punto(0, x0 + x, y0 + y)))
                 for y in range(al) for x in range(an)])
    return img.resize((an * escala, al * escala), Image.NEAREST)


def coteja(ruta=os.path.join(G.RAIZ, "work", "v_pasadizos")):
    """Cada vNN: lo que se ve (0xCDB2, 0xCDCC, 0xCDB3-0xCDC2, 0xCDC9-0xCDCB)
    contra la RAM, los puntos de la pagina 0 en el recorte y los sprites de
    0xEE00/0xEC00. En 5 volcados (1-1, 1-4, 3-1, 5-2, 7-0) la copia de sprites
    de la entrada esta pisada (y = 0x42, color 0: no se ven) y no hay flecha;
    tools/lanza_pasadizos.sh entra desde la calle poniendo al jugador a mano,
    no desde el interior 16. Andado solo (lanza_recorrido.sh 1), la flecha esta
    desde el primer movimiento. Esos se cuentan aparte, sin darlos por buenos."""
    cart = G.Cartucho()
    malos = vistos = pisados = 0
    for f in sorted(glob.glob(os.path.join(ruta, "v*.vram"))):
        z = int(os.path.basename(f)[1:3])
        ram = open(f[:-5] + ".ram", "rb").read()
        d = open(f, "rb").read()
        x, y, dd = ram[0xDC6], ram[0xDC7], ram[0xDC4]
        vr, capa, v = pantalla(cart, z, x, y, dd)
        suya = dict(cdb2=ram[0xDB2], cdcc=ram[0xDCC], cdb3=list(ram[0xDB3:0xDBB]),
                    cdbb=list(ram[0xDBB:0xDC3]), cdc9=list(ram[0xDC9:0xDCC]))
        x0, y0, an, al = RECORTE
        puntos = sum(1 for yy in range(y0, y0 + al) for xx in range(x0, x0 + an)
                     if vr.punto(0, xx, yy) != (d[yy * 128 + xx // 2] >> (4 * (1 - xx % 2))) & 15)
        lista, colores = sprites(cart, v, dd)
        sus = [tuple(ram[0x2E00 + 4 * i:0x2E03 + 4 * i]) for i in range(32)]
        sus_c = [list(ram[0x2C00 + 16 * i:0x2C10 + 16 * i]) for i in range(32)]
        vistos_s = [i for i in range(32) if lista[i][0] != 0xE0 or sus[i][0] != 0xE0]
        spr = all(lista[i] == sus[i] and colores[i] == sus_c[i] for i in vistos_s)
        pisada = sus[0][0] != 0x30 and all(c == 0 for c in sus_c[0])
        bien = suya == v and puntos == 0 and (spr or pisada)
        vistos += 1
        malos += not bien
        pisados += pisada
        print("zona %d-%d en (%d, %d) mirando %d: vista %s, %d puntos distintos, sprites %s"
              % (z // 7 + 1, z % 7, x, y, dd, "igual" if suya == v else "DISTINTA", puntos,
                 "iguales" if spr else "SIN COTEJAR (copia pisada en el volcado)" if pisada else "DISTINTOS"))
    print("%d vistas, %d distintas; sprites sin cotejar en %d (copia pisada)" % (vistos, malos, pisados))
    return malos


def coteja_z80(zonas=None):
    """Ejecuta con tools/z80run.py monta_el_pasadizo_secreto (p00:59A9, el
    banco 9 en 0xA000) y, en cada casilla de paso y cada direccion, la vista
    (p03:B936); compara 0xCDB2-0xCDCC con lo_que_se_ve."""
    from motor_musica import Cartucho

    class Z80Rom(Cartucho):
        def _una(self):
            if self.mem[self.pc] == 0xE7:           # rst 20h: DCOMPR de la BIOS
                hl, de = self.h << 8 | self.l, self.d << 8 | self.e
                self.f = (0x40 if hl == de else 0) | (0x01 if hl < de else 0)
                self.pc += 1
                return
            Cartucho._una(self)
    cart = G.Cartucho()
    malos = vistas = 0
    for z in zonas or sorted(P.zonas_con_pasadizo(cart)):
        m = Z80Rom(dict(mapper="konami", org=0x4000), cart.rom)
        m.sp = 0xF000
        m.mem[0xC288], m.mem[0xC280] = z // 7, z % 7
        m.pon_banco(0xA000, 9)
        m.corre(0x59A9)
        m.pon_banco(0xA000, 3)
        rejilla = P.pasadizo(cart, z)[3]
        mal = 0
        for y in range(len(rejilla)):
            for x in range(len(rejilla[0])):
                if rejilla[y][x] == 1:
                    continue
                for d in range(4):
                    m.mem[0xCDC6], m.mem[0xCDC7], m.mem[0xCDC4] = x, y, d
                    m.corre(0xB936)
                    suya = dict(cdb2=m.mem[0xCDB2], cdcc=m.mem[0xCDCC], cdb3=list(m.mem[0xCDB3:0xCDBB]),
                                cdbb=list(m.mem[0xCDBB:0xCDC3]), cdc9=list(m.mem[0xCDC9:0xCDCC]))
                    vistas += 1
                    mal += suya != lo_que_se_ve(rejilla, x, y, d)
        malos += mal
        print("zona %d-%d: %d distintas" % (z // 7 + 1, z % 7, mal))
    print("%d vistas ejecutadas, %d distintas" % (vistas, malos))
    return malos


def coteja_recorridos(ruta=os.path.join(G.RAIZ, "work", "v_recorrido")):
    """Cada zNN de tools/lanza_recorrido.sh: tras cada movimiento, la casilla
    y la direccion de la RAM contra recorrido(), y los puntos del recorte de
    la pagina 0 contra lo dibujado."""
    cart = G.Cartucho()
    malos = 0
    for carpeta in sorted(glob.glob(os.path.join(ruta, "z*"))):
        z = int(os.path.basename(carpeta)[1:])
        base = vram_del_pasadizo(cart, z)
        _a, estados = recorrido(cart, z)
        vol = sorted(glob.glob(os.path.join(carpeta, "r*.vram")))
        mal = 0
        for k, f in enumerate(vol):
            (x, y, d), rejilla = estados[k]
            ram = open(f[:-5] + ".ram", "rb").read()
            dd = open(f, "rb").read()
            vr = G.Vram()
            vr.v[:] = base.v
            v = lo_que_se_ve(rejilla, x, y, d)
            for n in dibujos(v):
                pinta_dibujo(cart, vr, n)
            marco(cart, vr)
            x0, y0, an, al = RECORTE
            puntos = sum(1 for yy in range(y0, y0 + al) for xx in range(x0, x0 + an)
                         if vr.punto(0, xx, yy) != (dd[yy * 128 + xx // 2] >> (4 * (1 - xx % 2))) & 15)
            sitio = (ram[0xDC6], ram[0xDC7], ram[0xDC4]) == (x, y, d)
            mal += not (sitio and puntos == 0)
            if not (sitio and puntos == 0):
                print("  %s: RAM (%d, %d, %d), nuestro (%d, %d, %d), %d puntos distintos"
                      % (os.path.basename(f), ram[0xDC6], ram[0xDC7], ram[0xDC4], x, y, d, puntos))
        print("recorrido de la zona %d-%d: %d cuadros de %d, %d distintos"
              % (z // 7 + 1, z % 7, len(vol), len(estados), mal))
        malos += mal + (len(vol) != len(estados))
    return malos


def main():
    if sys.argv[1:2] == ["pasos"]:
        print("".join(recorrido(G.Cartucho(), int(sys.argv[2]))[0][:-1]))
        return
    if sys.argv[1:] == ["coteja"]:
        malos = coteja() + coteja_z80()
        if os.path.isdir(os.path.join(G.RAIZ, "work", "v_recorrido")):
            malos += coteja_recorridos()
        sys.exit(1 if malos else 0)
    cart = G.Cartucho()
    for z in sorted(P.zonas_con_pasadizo(cart)):
        ruta = os.path.join(G.IMAGENES, "vista_%d_%d.gif" % (z // 7 + 1, z % 7))
        print(ruta, gif(cart, z, ruta), "cuadros")
    print(piezas(cart, os.path.join(G.IMAGENES, "vistas_piezas.png")))


if __name__ == "__main__":
    main()
