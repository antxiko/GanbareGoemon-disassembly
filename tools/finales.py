#!/usr/bin/env python3
"""Los cuatro finales, dibujados desde las tablas del cartucho.

  El estado 0x0F (p01:6292) llega tras la fase 7 (p01:6186). Hasta ahi la
  ultima paleta puesta es la de la pantalla del final de fase (p01:612E ->
  p00:4D72: la base 0xA3E6 y encima 0xA48F, banco 9); el estado 0x0F no pone
  otra. Las letras siguen en la pagina 1 desde la carga de p00:4A6D (0x91 del
  color 0x0E en (0x00, 0x40) y 10 del color 3 en (0x88, 0x60)).

  paso 0  p01:62E5: texto_del_final (p01:653C) monta en 0xD800 uno de cuatro
          textos: B = 2 con el vecino en la otra ranura (0xEF00 distinto de
          0), +1 con las 7 fases pasadas una a una (0xC26A = 7); la tabla de
          0x6589 da los trozos (0xBCD3, banco 12), con dos 0xFE detras de cada
          uno y 0xFF al final. Se borra la pantalla y p00:42F1 lo saca letra a
          letra desde (0x20, 0x10), una cada 4 cuadros, con la musica 0x0D.
  paso 1  p01:62AE: al acabar la musica, la pantalla se borra y salen los 16
          sprites de 0x65C7 (dibujos en rle de 0xBE32, banco 6, a 0xF800),
          todos del color 3, con la musica 0x0F. Es la misma en los cuatro.

Uso:  finales.py     escribe docs/imagenes/final_0..3.png y final_sprites.png
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import graficos as G  # noqa: E402
import titulo as T  # noqa: E402

S1, S4, S7, S10, S13 = G.S1, G.S4, G.S7, G.S10, G.S13
ESCALA = 2


def vram_del_final(cart):
    """La pagina 1 con las letras (p00:4A6D) y la paleta de p00:4D72."""
    v = G.Vram()
    G.letras(G.de_la_rom(cart, S13, 0x929D, 0x91 * 8), 0x00, 0x40, 0x91, 0x0E, v)
    G.letras(G.de_la_rom(cart, S13, 0x9725, 10 * 8), 0x88, 0x60, 10, 0x03, v)
    G.pon_paleta(cart, S7, 0xA3E6, v)
    G.pon_paleta(cart, S7, 0xA48F, v)
    return v


def texto_del_final(cart, k):
    """p01:653C: los bytes que quedan en 0xD800 para el final k."""
    a = cart.palabra(0x6589 + 2 * k, S1)
    d800 = []
    for i in range(cart.leer(a, S1)):
        f = cart.palabra(0xBCD3 + 2 * cart.leer(a + 1 + i, S1), S10)
        d800 += [cart.leer(f + 1 + j, S10) for j in range(cart.leer(f, S10))]
        d800 += [0xFE, 0xFE]
    d800[-1] = 0xFF
    return d800


def saca_el_texto(v, texto, x=0x20, y=0x10):
    """p00:42E1 y p00:42F1 hasta el 0xFF: 0xFE baja 8 desde el principio del
    renglon, 0xE1-0xFD avanza (n - 0xE0) letras, 0xE0 acaba; las marcas 0x62
    y 0x63 avanzan 4 puntos y las demas letras 8. Devuelve las letras."""
    x0, n = x, 0
    for c in texto:
        if c == 0xFF or c == 0xE0:
            break
        if c == 0xFE:
            y += 8
            x = x0
        elif c > 0xE0:
            x = (x + (c - 0xE0) * 8) & 0xFF
        else:
            T.letra(v, c, x, y)
            n += 1
            x = (x + (4 if c in (0x62, 0x63) else 8)) & 0xFF
    return n


def pantalla_de_texto(cart, k):
    v = vram_del_final(cart)
    n = saca_el_texto(v, texto_del_final(cart, k))
    return v, n


def pantalla_de_sprites(cart):
    """p01:62AE: rle de 0xBE32 a 0xF800 (p00:4CD4) y los 16 sprites de
    p01:65A2, con el color 3 en las 16 lineas de cada uno."""
    v = vram_del_final(cart)
    G.rle_a_la_vram(cart, S4, 0xF800, 0xBE32, v)
    lista = [tuple(cart.leer(0x65C7 + 3 * i + j, S1) for j in range(3)) for i in range(16)]
    return v, T.sprites(v, lista, [[3] * 16] * 16)


def coteja():
    """Ejecuta texto_del_final (p01:653C) con tools/z80run.py en las cuatro
    combinaciones de 0xEF00 y 0xC26A y compara 0xD800 con texto_del_final."""
    from motor_musica import Cartucho as Z80Rom
    cart = G.Cartucho()
    fallos = 0
    for k in range(4):
        z = Z80Rom(dict(mapper="konami", org=0x4000), cart.rom)
        z.sp = 0xF000
        z.mem[0xEF00] = 0xFF if k & 2 else 0
        z.mem[0xC26A] = 7 if k & 1 else 6
        z.corre(0x653C)
        esperado = texto_del_final(cart, k)
        sale = list(z.mem[0xD800:0xD800 + len(esperado)])
        igual = sale == esperado
        print("final %d (0xEF00=%02X, 0xC26A=%d): %d bytes en 0xD800, %s" % (
            k, z.mem[0xEF00], z.mem[0xC26A], len(esperado), "iguales" if igual else "DISTINTOS"))
        fallos += not igual
    return fallos


def coteja_omsx(ruta=os.path.join(G.RAIZ, "work", "v_final")):
    """Contra los volcados de tools/lanza_final.sh (el final 1 por su camino):
    la paleta en los colores que se usan (0, 3 y 14; los que no estan en las
    listas guardan los de la zona), la pagina 0 del texto y los sprites que
    salen en las 212 lineas (atributos en 0xF600, colores en 0xF400)."""
    cart = G.Cartucho()
    fallos = 0
    for n in ("texto", "sprites"):
        p = open(os.path.join(ruta, n + ".pal"), "rb").read()
        pal = [((p[2 * i] >> 4) & 7, p[2 * i + 1] & 7, p[2 * i] & 7) for i in range(16)]
        mia = vram_del_final(cart).paleta
        malos = [i for i in (0, 3, 14) if pal[i] != mia[i]]
        print("paleta (%s): colores 0, 3 y 14 %s" % (n, "iguales" if not malos else "DISTINTOS %s" % malos))
        fallos += bool(malos)
    vr = open(os.path.join(ruta, "texto.vram"), "rb").read()
    v, _ = pantalla_de_texto(cart, 1)
    dif = sum(1 for y in range(212) for x in range(256)
              if v.punto(0, x, y) != ((vr[y * 128 + x // 2] >> 4) if x % 2 == 0 else vr[y * 128 + x // 2] & 15))
    print("final 1, pagina 0: %d puntos distintos" % dif)
    vs = open(os.path.join(ruta, "sprites.vram"), "rb").read()
    w = G.Vram()
    w.v[:] = vs
    lista = [tuple(vs[0xF600 + 4 * i:0xF603 + 4 * i]) for i in range(32)]
    colores = [list(vs[0xF400 + 16 * i:0xF410 + 16 * i]) for i in range(32)]
    suya = {p: c for p, c in T.sprites(w, lista, colores).items() if p[1] < 212}
    mia = {p: c for p, c in pantalla_de_sprites(cart)[1].items() if p[1] < 212}
    print("ultima pantalla: %d puntos de sprite, %s" % (len(suya), "iguales" if suya == mia else "DISTINTOS"))
    return fallos + (dif != 0) + (suya != mia)


def main():
    if sys.argv[1:2] == ["coteja"]:
        malos = coteja()
        if os.path.isdir(os.path.join(G.RAIZ, "work", "v_final")):
            malos += coteja_omsx()
        return 1 if malos else 0
    cart = G.Cartucho()
    for k in range(4):
        v, n = pantalla_de_texto(cart, k)
        ruta = G.guarda_png(T.imagen(v, 0), os.path.join(G.IMAGENES, "final_%d.png" % k), ESCALA)
        print("final %d: %d letras, %d cuadros (una cada 4) -> %s" % (k, n, 4 * n, ruta))
    v, capa = pantalla_de_sprites(cart)
    print("ultima pantalla:", G.guarda_png(T.imagen(v, 0, capa), os.path.join(G.IMAGENES, "final_sprites.png"), ESCALA))


if __name__ == "__main__":
    main()
