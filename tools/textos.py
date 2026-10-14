#!/usr/bin/env python3
"""Los textos de Ganbare Goemon, pasados a limpio desde la ROM.

LA FUENTE (p00:4A6D): 0x91 letras de 1 bit desde 0x929D (banco 14); la letra
del codigo c esta en la pagina 1 en x = (c mod 32) * 8, y = (c / 32) * 8 +
0x38 (p00:491C), asi que la primera que se sube es la 0x20. Codigos, mirados
en work/fuente.png: 0x20-0x29 cifras, 0x2A-0x2F KONAMI, 0x30-0x5D hiragana en
el orden del gojuon (a i u e o ka ...), 0x5E-0x61 las pequenas (tsu ya yu yo),
0x62 handakuten y 0x63 dakuten (van detras de la letra, p00:4313), 0x64-0x6A
puntuacion y 両 (ryo); de 0x6B en adelante, trozos de dibujos.

LOS ROTULOS (p00:48F3): [x][y] y las letras; 0xFE [x][y] otra posicion,
0xFF acaba; la tabla de 0xA9C0 (banco 12) tiene 120 punteros (p00:4280).
LOS TEXTOS LETRA A LETRA (p00:42F1): 0xFE renglon nuevo, 0xE0 + n un hueco de
n letras, 0xFF acaba.

Uso: textos.py     escribe work/textos.txt
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import graficos as G  # noqa: E402

GOJUON = ("あいうえお" "かきくけこ" "さしすせそ" "たちつてと" "なにぬねの" "はひふへほ"
          "まみむめも" "やゆよ" "らりるれろ" "わをん")
SMALL = "っゃゅょ"
DAKU = dict(zip("かきくけこさしすせそたちつてとはひふへほ", "がぎぐげござじずぜぞだぢづでどばびぶべぼ"))
HANDAKU = dict(zip("はひふへほ", "ぱぴぷぺぽ"))
PUNT = {0x64: "。", 0x65: "、", 0x66: "ー", 0x67: "?", 0x68: "!", 0x69: "◎", 0x6A: "両"}


def letra(c):
    if c in (0, 0x1F):
        return " "
    if 0x20 <= c <= 0x29:
        return str(c - 0x20)
    if 0x2A <= c <= 0x2F:
        return "KONAMI"[c - 0x2A]
    if 0x30 <= c <= 0x5D:
        return GOJUON[c - 0x30]
    if 0x5E <= c <= 0x61:
        return SMALL[c - 0x5E]
    if c in PUNT:
        return PUNT[c]
    return "[%02X]" % c


def junta(cs):
    """Las letras, con las marcas de sonido sobre la de antes."""
    out = ""
    for c in cs:
        if c == 0x63 and out and out[-1] in DAKU:
            out = out[:-1] + DAKU[out[-1]]
        elif c == 0x62 and out and out[-1] in HANDAKU:
            out = out[:-1] + HANDAKU[out[-1]]
        elif c in (0x62, 0x63):
            out += "゛" if c == 0x63 else "゜"
        else:
            out += letra(c)
    return out


def rotulo(cart, a, bancos):
    """[x][y] letras; 0xFE otra posicion; 0xFF acaba. Devuelve los trozos."""
    trozos = []
    x, y = cart.leer(a, bancos), cart.leer(a + 1, bancos)
    a += 2
    cs = []
    while True:
        c = cart.leer(a, bancos)
        a += 1
        if c == 0xFF:
            trozos.append(((x, y), junta(cs)))
            return trozos
        if c == 0xFE:
            trozos.append(((x, y), junta(cs)))
            x, y = cart.leer(a, bancos), cart.leer(a + 1, bancos)
            a += 2
            cs = []
            continue
        cs.append(c)


def texto(cart, a, bancos, limite=400):
    """El formato de p00:42F1."""
    renglones, cs = [], []
    for _ in range(limite):
        c = cart.leer(a, bancos)
        a += 1
        if c == 0xFF:
            break
        if c == 0xFE:
            renglones.append(junta(cs))
            cs = []
        elif c >= 0xE0:
            cs += [0] * (c - 0xE0)
        else:
            cs.append(c)
    renglones.append(junta(cs))
    return renglones


# ---------------------------------------------------------------------------
# TODOS LOS TEXTOS, CON QUIEN LOS PIDE (para la pagina LOS-TEXTOS / THE-TEXTS)
#
# Los rotulos de la tabla los piden rotulo_numero (p00:4280) y caja_y_texto
# (p03:B836) con el numero en A: en los bytes hay 22 llamadas o saltos a 0x4280
# y 18 a 0xB836, los mismos que el listado. A cada una se le busca el numero:
# un `ld a,n` delante o, donde se calcula, la tabla o las ramas de PIDE_A_MANO.
# ---------------------------------------------------------------------------
S3 = (1, 2, 3)
N_ROTULOS = 0x72
TABLA_ROTULOS = 0xA9C0
FIN_ROTULOS = 0xB6D2            # los punteros 114-119 apuntan aqui: no hay rotulo
DIBUJO = 0x6B                   # de aqui en adelante, trozos de dibujos y letras grandes
MARCA = (0xBC, 0xBD)            # la marca de la opcion (p00:4476)


def _seguidos(cart, a, n, bancos):
    return [cart.leer(a + i, bancos) for i in range(n)]


def _rotulo_de_interior(cart):
    """p02:925D: la ficha de cada interior (0x9567): tipos hasta 0, dos bytes y el rotulo."""
    out = {}
    for n in range(21):
        a = cart.palabra(0x9567 + 2 * n, G.S1)
        while cart.leer(a, G.S1):
            a += 1
        out.setdefault(cart.leer(a + 3, G.S1), []).append(n)
    return out


def _pide_a_mano(cart):
    """Los sitios donde el numero no va en un `ld a,n` justo delante."""
    return {
        "p02:92AA": [n for n in _rotulo_de_interior(cart) if n != 0xFF],
        "p03:AD72": [0x6F, 0x70],                        # la tienda cerrada (interior 0-7 / 8-15)
        "p03:AEED": _seguidos(cart, 0xAEF1, 8, S3),      # la tienda: interior / 4 y C (0 o 4)
        "p03:B1B7": [0x1C, 0x1D],                        # 0x1D en la zona 6
        "p03:B285": [0x0A, 0x0B],                        # par o impar
        "p03:B5C2": [0x6E, 0x07],
        "p03:B6C1": _seguidos(cart, 0xB716, 7, S3),      # el adivino, por las visitas
        "p03:B6FA": [0x1E, 0x1F],                        # 0x1F en la zona 6
        "p03:B78D": list(range(0x20, 0x20 + 0x46)),      # texto_al_azar: 0x20 + (0-0x16, 0x36 o 0x45)
    }


def sitios_que_piden(raiz=None):
    """[(sitio, rutina)] de cada call/jp a rotulo_numero o caja_y_texto del listado."""
    import glob
    import re
    raiz = raiz or G.RAIZ
    destino = re.compile(r"\t(?:call|jp)\s+(?:(?:n?z|n?c|p|m|pe|po),)?(04280h|rotulo_numero|caja_y_texto|0b836h)\b")
    out = []
    for f in sorted(glob.glob(os.path.join(raiz, "src", "goemon_p*.asm"))):
        banco = int(os.path.basename(f)[8:10])
        with open(f, encoding="utf-8") as fh:
            lineas = fh.read().split("\n")
        for i, l in enumerate(lineas):
            m = destino.search(l)
            if m:
                dire = l.split(";")[1].strip()[:4]
                out.append(("p%02d:%s" % (banco, dire.upper()), m.group(1), lineas[max(0, i - 8):i]))
    return out


def pedidos(cart):
    """{numero de rotulo: [sitios que lo piden]}."""
    import re
    a_mano = _pide_a_mano(cart)
    out = {}
    for sitio, _, antes in sitios_que_piden():
        if sitio == "p03:B840":         # caja_y_texto pinta el A que le pasan
            continue
        if sitio in a_mano:
            numeros = a_mano[sitio]
        else:
            numeros = None
            for l in reversed(antes):
                m = re.match(r"\tld a,0?([0-9a-f]+)h\s", l)
                if m:
                    numeros = [int(m.group(1), 16)]
                    break
                if re.match(r"\txor a\s", l):
                    numeros = [0]
                    break
                if re.match(r"\tld a,|^\w+:", l):
                    raise SystemExit("no se sabe que rotulo pide " + sitio)
        for n in numeros:
            out.setdefault(n, []).append(sitio)
    return out


# Los rotulos fijos fuera de la tabla: (direccion del banco 1, formato, quien lo lee).
# formato "r" = [x][y] y letras (0x48F3); "s" = sin posicion (0x48FD).
SUELTOS = [
    (0x639B, "r", ["p00:5B06", "p00:5E5E"], "titulo"),
    (0x63DB, "r", ["p00:5FD2"], "fin"),
    (0x63E3, "r", ["p00:5F9B", "p00:5FDE"], "continuar"),
    (0x636C, "r", ["p01:6369"], "pausa"),
    (0x628A, "s", ["p01:6284"], "contrasena"),
    (0x6CCC, "r", ["p01:6BDB"], "contrasena_f2"),
    (0x7F41, "r", ["p01:7F25"], "vecino"),
    (0x7F94, "r", ["p01:7F86"], "vecino_1"),
    (0x7FB9, "r", ["p01:7FA6"], "vecino_2"),
    (0x642D, "r", ["p00:43EE"], "marcador_1"),
    (0x6435, "r", ["p00:43EE"], "marcador_2"),
    (0x63F0, "r", ["p00:43F4"], "marcador"),
    (0x640F, "r", [], "jugador_1"),
    (0x641D, "r", [], "jugador_2"),
]


def codigos_de_rotulo(cart, a, bancos):
    """[((x, y), [codigos])] de un rotulo de 0x48F3."""
    trozos = []
    x, y = cart.leer(a, bancos), cart.leer(a + 1, bancos)
    a += 2
    cs = []
    while True:
        c = cart.leer(a, bancos)
        a += 1
        if c in (0xFE, 0xFF):
            trozos.append(((x, y), cs))
            if c == 0xFF:
                return trozos
            x, y = cart.leer(a, bancos), cart.leer(a + 1, bancos)
            a += 2
            cs = []
        else:
            cs.append(c)


def codigos_sin_posicion(cart, a, bancos):
    cs = []
    while cart.leer(a, bancos) != 0xFF:
        cs.append(cart.leer(a, bancos))
        a += 1
    return cs


def es_dibujo(trozos):
    return any(c >= DIBUJO for _, cs in trozos for c in cs)


def plano(cs):
    """Las letras de un trozo sin los huecos de los lados; un hueco de tres o
    mas letras en medio, o de dos o mas delante, sale como «…»."""
    import re
    t = junta(cs).rstrip()
    if not t.strip():
        return ""
    t = re.sub(r"^ {2,}", "…", t)
    return re.sub(r" {3,}", " … ", t).strip()


def texto_lineas(cart, a, bancos):
    return [r.strip() for r in texto(cart, a, bancos)]


def frase_lineas(cart, a, bancos):
    """Un trozo del final: [n] y n letras; 0xFE baja un renglon (p00:42F1)."""
    largo = cart.leer(a, bancos)
    cs = _seguidos(cart, a + 1, largo, bancos)
    lineas, uno = [], []
    for c in cs:
        if c == 0xFE:
            lineas.append(junta(uno).strip())
            uno = []
        else:
            uno.append(c)
    lineas.append(junta(uno).strip())
    return [l for l in lineas if l]


def todos(cart=None):
    """Todos los textos: [dict(clave, grupo, sitio, lineas, trozos, quien)]."""
    cart = cart or G.Cartucho()
    S10, S15 = G.S10, (1, 2, 15)
    out = []
    for a, fmt, quien, nombre in SUELTOS:
        if fmt == "r":
            trozos = codigos_de_rotulo(cart, a, G.S1)
        else:
            trozos = [(None, codigos_sin_posicion(cart, a, G.S1))]
        out.append(dict(clave=nombre, grupo="menu", sitio="p01:%04X" % a, quien=quien, trozos=trozos,
                        lineas=[plano(cs) for _, cs in trozos if plano(cs) and not set(cs) <= set(MARCA)]))
    piden = pedidos(cart)
    punteros = {}
    for n in range(N_ROTULOS):
        a = cart.palabra(TABLA_ROTULOS + 2 * n, S10)
        trozos = codigos_de_rotulo(cart, a, S10)
        out.append(dict(clave="r%02X" % n, grupo="rotulo", n=n, sitio="p12:%04X" % a,
                        quien=sorted(set(piden.get(n, []))), trozos=trozos, igual=None,
                        lineas=[plano(cs) for _, cs in trozos if plano(cs)]))
        if a in punteros:               # dos numeros con el mismo puntero
            out[-1]["igual"], punteros[a]["igual"] = punteros[a]["n"], n
        punteros.setdefault(a, out[-1])
    trozos = codigos_de_rotulo(cart, 0xAFDE, S10)
    out.append(dict(clave="rAFDE", grupo="rotulo", n=None, sitio="p12:AFDE", quien=[], trozos=trozos,
                    lineas=[plano(cs) for _, cs in trozos]))
    for n in range(35):
        a = cart.palabra(0xBC16 + 2 * n, S15)
        out.append(dict(clave="z%02d" % n, grupo="zona", n=n, sitio="p15:%04X" % a, quien=["p02:962F"],
                        lineas=texto_lineas(cart, a, S15)))
    for n in range(7):
        a = cart.palabra(0x9E0B + 2 * n, G.S1)
        out.append(dict(clave="f%d" % n, grupo="fase", n=n, sitio="p02:%04X" % a, quien=["p02:9B9E"],
                        lineas=texto_lineas(cart, a, G.S1)))
    out.append(dict(clave="f_mal", grupo="fase", n=None, sitio="p02:9F92", quien=["p02:9B9E"],
                    lineas=texto_lineas(cart, 0x9F92, G.S1)))
    for n in range(7):
        a = cart.palabra(0xBCD3 + 2 * n, S10)
        out.append(dict(clave="e%d" % n, grupo="final", n=n, sitio="p12:%04X" % a, quien=["p01:656B"],
                        lineas=frase_lineas(cart, a, S10)))
    for k, a in enumerate((0xBE44, 0xBE49)):
        out.append(dict(clave="pausa%d" % k, grupo="clave", sitio="p03:%04X" % a, quien=["p03:BE13"],
                        lineas=[junta(_seguidos(cart, a, 5, S3))]))
    for k in range(4):
        a = 0xBE8A + 9 * k
        out.append(dict(clave="clave%d" % k, grupo="clave", sitio="p03:%04X" % a, quien=["p03:BE4E"],
                        lineas=[junta(_seguidos(cart, a, 9, S3)).strip()]))
    return out


def finales(cart=None):
    """Los cuatro finales (p01:655A): la lista de trozos de 0x6589 de cada uno."""
    cart = cart or G.Cartucho()
    out = []
    for k in range(4):
        a = cart.palabra(0x6589 + 2 * k, G.S1)
        out.append(_seguidos(cart, a + 1, cart.leer(a, G.S1), G.S1))
    return out


def imagen_rotulo(cart, trozos, ruta, escala=3):
    """El rotulo pintado letra a letra como p00:48FD: HMMM de 8x8 desde la
    pagina 1 (la letra entera, tambien los puntos a 0), 8 puntos a la derecha
    y 4 tras las marcas 0x62 y 0x63. Letras de 0x929D (0x20-0xB0) y 0x9725
    (0xB1-0xBA), las dos que sube letras_del_texto (p00:4A6D)."""
    fuente = G.de_la_rom(cart, G.S13, 0x929D, 0x91 * 8) + G.de_la_rom(cart, G.S13, 0x9725, 10 * 8)
    puntos = {}
    for (x, y), cs in trozos:
        for c in cs:
            k = (c - 0x20) * 8
            if c and not (0 <= k < len(fuente)):
                raise ValueError("letra 0x%02X fuera de la fuente" % c)
            for fy in range(8):
                b = fuente[k + fy] if c else 0
                for fx in range(8):
                    puntos[(x + fx, y + fy)] = bool(b & (0x80 >> fx))
            x += 4 if c in (0x62, 0x63) else 8
    encendidos = [p for p, v in puntos.items() if v]
    x0 = min(p[0] for p in encendidos) - 4
    x1 = max(p[0] for p in encendidos) + 5
    y0 = min(p[1] for p in encendidos) - 4
    y1 = max(p[1] for p in encendidos) + 5
    img = [[(255, 255, 255) if puntos.get((x, y)) else (0, 0, 0) for x in range(x0, x1)] for y in range(y0, y1)]
    return G.guarda_png(img, ruta, escala)


def main():
    if sys.argv[1:2] == ["pagina"]:
        import textos_pagina
        return textos_pagina.pagina(os.path.join(G.RAIZ, "docs"))
    cart = G.Cartucho()
    S10 = G.S10
    out = ["ROTULOS (0xA9C0, banco 12)"]
    for n in range(0x72):
        a = cart.palabra(0xA9C0 + 2 * n, S10)
        out.append("%02X @%04X  " % (n, a) + "  |  ".join("(%02X,%02X) %s" % (x, y, t) for (x, y), t in rotulo(cart, a, S10)))
    out.append("")
    out.append("TEXTOS DE LA ZONA PASADA (0xBC16, banco 15; fase * 5 + zona - 1)")
    S15 = (1, 2, 15)
    for n in range(35):
        a = cart.palabra(0xBC16 + 2 * n, S15)
        out.append("%2d @%04X  %s" % (n, a, " / ".join(texto(cart, a, S15))))
    out.append("")
    out.append("TEXTOS DEL FINAL DE FASE (0x9E0B y 0x9F92, banco 2)")
    for n in range(7):
        a = cart.palabra(0x9E0B + 2 * n, G.S1)
        out.append("fase %d @%04X  %s" % (n, a, " / ".join(texto(cart, a, G.S1))))
    out.append("0x9F92  %s" % " / ".join(texto(cart, 0x9F92, G.S1)))
    out.append("")
    out.append("FRASES DEL FINAL (0xBCD3, banco 12) y sus cuatro textos (0x6589)")
    frases = []
    for n in range(40):
        a = cart.palabra(0xBCD3 + 2 * n, S10)
        if not (0x8000 <= a < 0xC000):
            break
        largo = cart.leer(a, S10)
        frases.append(junta([cart.leer(a + 1 + i, S10) for i in range(largo)]))
        out.append("%2d @%04X  %s" % (n, a, frases[-1]))
    for k in range(4):
        a = cart.palabra(0x6589 + 2 * k, G.S1)
        n = cart.leer(a, G.S1)
        out.append("final %d: %s" % (k, " ".join(str(cart.leer(a + 1 + i, G.S1)) for i in range(n))))
    out.append("(final 0: sin el vecino y sin las 7 fases jugadas; 1: con las 7; 2: con el vecino; 3: las dos, p01:6546)")
    out.append("")
    out.append("PALABRAS DE LA PAUSA (0xBE44, p03:BE13) Y CLAVES DE LA CONTRASENA (0xBE8A, p03:BE4E)")
    S3 = (1, 2, 3)
    out.append("0xBE44 %s  (dentro del pasadizo secreto: bit 0 de 0xEF80 y el mapa, 0xC27A)" % junta([cart.leer(0xBE44 + i, S3) for i in range(5)]))
    out.append("0xBE49 %s  (fuera: bit 1, +10 ryo con los tipos 8 y 0x21)" % junta([cart.leer(0xBE49 + i, S3) for i in range(5)]))
    efecto = ["jugar con el jugador 2", "vida maxima 0x20", "2000 ryo", "continuar"]
    for k in range(4):
        out.append("clave %d %s  (bit %d de 0xEF80: %s)" % (k, junta([cart.leer(0xBE8A + 9 * k + i, S3) for i in range(9)]),
                                                          2 + k, efecto[k]))
    ruta = os.path.join(G.RAIZ, "work", "textos.txt")
    open(ruta, "w", encoding="utf-8", newline="\n").write("\n".join(out) + "\n")
    print(ruta)


if __name__ == "__main__":
    main()
