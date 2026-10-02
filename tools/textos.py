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


def main():
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
