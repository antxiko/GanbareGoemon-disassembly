# -*- coding: utf-8 -*-
"""La pagina LOS-TEXTOS / THE-TEXTS: todos los textos de tools/textos.py con
la traduccion de tools/textos_traduccion.py y los rotulos de dibujo pintados
desde la fuente de la ROM (docs/imagenes/texto_*.png).

Uso: textos.py pagina
"""
import os

import graficos as G
import textos as X
import textos_traduccion as T

PAGINA = {
    "es": dict(
        ruta=os.path.join("es", "LOS-TEXTOS.md"), img="../imagenes/",
        intro="""# Los textos

Ganbare Goemon! salió solo en japonés. Aquí están todos sus textos, sacados de la ROM con `tools/textos.py` (`make textos`), cada uno con su dirección, quién lo pide y una traducción. **La traducción es nuestra, no de Konami**, y no sale del parche de traducción al inglés de [MSX Translations](https://msxtranslations.com/goemon.php).

## Cómo se guardan

- **La fuente.** `letras_del_texto` (`p00:4A6D`) sube a la página 1 del VDP 0x91 letras de 1 bit desde `0x929D` (banco 14) y otras 10 desde `0x9725`. La letra c queda en x = (c mod 32) × 8, y = (c / 32) × 8 + 0x38 (`p00:491C`), así que la primera es la 0x20. Del 0x20 al 0x29 son las cifras, del 0x2A al 0x2F KONAMI, del 0x30 al 0x5D los hiragana en el orden del gojūon (あいうえお かきくけこ...), del 0x5E al 0x61 las pequeñas っゃゅょ, 0x62 y 0x63 las marcas ゜ y ゛ (van detrás de la letra y solo avanzan 4 puntos, `p00:490C`), del 0x64 al 0x6A la puntuación y 両 (ryō), y del 0x6B en adelante trozos de dibujo: letras grandes y marcos. No hay katakana ni kanji sueltos.
- **Los rótulos** se pintan de golpe (`rotulo`, `p00:48F3`): x, y y las letras; 0xFE cambia de posición y 0xFF acaba. Cada letra es una copia HMMM de 8 × 8 desde la página 1.
- **Los textos letra a letra** (`sigue_texto`, `p00:42F1`): 0xFE es renglón nuevo, 0xE0 + n deja n huecos y 0xFF acaba.
- **Los trozos del final** llevan delante cuántas letras tienen; `texto_del_final` (`p01:653C`) los junta en 0xD800 y se escriben letra a letra.

«…» en una traducción es un hueco en blanco del rótulo (en los dados, por ejemplo, ahí se pintan los dos números, `p03:B26D`). Los rótulos con dibujos van como imagen, pintados con las letras de la ROM en blanco sobre negro (en el juego salen del color de la paleta de cada pantalla).

## Quién pide cada rótulo

La tabla de `p12:A9C0` tiene 120 punteros; los seis últimos van a `0xB6D2`, donde acaban los rótulos, así que hay 114 (0x00-0x71). Los piden `rotulo_numero` (`p00:4280`) y `caja_y_texto` (`p03:B836`) con el número en A. En los bytes de la ROM hay {n4280} llamadas o saltos a 0x4280 y {nb836} a 0xB836, los mismos que el listado, y de todos se sabe el número que pasan: un `ld a` delante, una tabla o una cuenta.

- Los dos que no pide nadie son el **0x10**, que apunta al mismo texto que el 0x11, y el **0x17** («Señor, la tienda ha cerrado»); la tienda cerrada usa el 0x6F y el 0x70 (`p03:AD72`).
- Los del **0x20 al 0x65** los saca `texto_al_azar` (`p03:B75E`) en el interior 20: 0x20 más el anterior y un número de 0 a 15 sacado del registro R, dando la vuelta en 0x17; en 0x37 si se llevan las cosas 3 y 4 del marcador, y en 0x46 si además se lleva la 0x0A. Por eso salen primero las frases (0x20-0x36), luego los consejos en verso (0x37-0x56) y al final los que dicen las claves (0x57-0x65).
- En `p12:AFDE`, justo detrás del 0x34 y en la altura del renglón siguiente (y = 0x50), hay un trozo de rótulo, «である。», al que no apunta ningún puntero. El 0x34 acaba con 0xFF antes y se queda en tres renglones.
- Del 0x58 al 0x5E el final de los dos últimos renglones son letras que no forman palabras (se dejan sin traducir). No se ha mirado si esconden algo.
""",
        h_menus="## Los rótulos del banco 1\n\nEl título, la pausa, la contraseña, el menú del vecino y el marcador. Los de 0x640F y 0x641D (el nombre de cada jugador con «はじまり») no los escribe nadie.",
        h_rotulos="## Los 114 rótulos de la tabla\n\nInteriores: 0-15 tiendas, 16 la entrada al pasadizo secreto, 17 los dados, 18 la posada, 19 la casa de empeños que pide la carta del jefe, 20 el que da consejos.",
        h_zona="## Al pasar de zona\n\n35 textos (`p15:BC16`), uno por zona, que `p02:962F` escribe letra a letra: el número es fase × 5 + zona − 1.",
        h_fase="## El señor de cada fase\n\nSiete textos (`p02:9E0B`), uno por fase, que escribe `p02:9B9E`. En las fases 0 a 5, si se ha golpeado 8 veces o más a la figura de tipo 0x21 (0xCD60, `p03:A9D3`), sale en su lugar el de `p02:9F92` (ver [Hallazgos](HALLAZGOS.md)).",
        h_final="## El final\n\nSiete trozos (`p12:BCD3`). `texto_del_final` (`p01:6546`) elige uno de cuatro finales por dos cosas: si el vecino (Q*bert o el Game Master) está en la otra ranura (0xEF00) y si se han pasado las 7 fases una a una (0xC26A = 7). Cada final es una lista de trozos (`p01:6589`).",
        h_finales="| Final | Vecino | 7 fases | Trozos |\n|---|---|---|---|",
        h_pantallas="Así salen. Cada final se escribe letra a letra desde (0x20, 0x10), una letra cada 4 cuadros, con la música 0x0D (`p01:62E5`). Al acabar la música se borra la pantalla y salen los 16 sprites de `0x65C7`: el kanji 終 («fin»), del color 3, con la música 0x0F (`p01:62AE`). Esa última pantalla es la misma en los cuatro finales. Dibujadas con `tools/finales.py`; el texto montado en 0xD800 se ha cotejado ejecutando `p01:653C` con z80run.",
        pie_final="Final %d", pie_ultima="La última pantalla",
        h_claves="## Las palabras secretas\n\nDos palabras de cinco letras que se teclean en la pausa (`p03:BE13`) y cuatro claves de nueve que acepta la pantalla de la contraseña (`p03:BE4E`); cada una pone un bit de 0xEF80. Lo que hacen está en [Hallazgos](HALLAZGOS.md).",
        cols="| | Japonés | Traducción | Lo pide |\n|---|---|---|---|",
        cols_r="| N.º | Japonés | Traducción | Lo pide |\n|---|---|---|---|",
        nadie="nadie", igual="el mismo texto que el 0x%02X", si="sí", no="no",
        efecto=["dentro del pasadizo secreto: bit 0 y el mapa", "fuera: bit 1, +10 ryo con los tipos 8 y 0x21",
                "bit 2: jugar con el jugador 2", "bit 3: vida máxima 0x20", "bit 4: 2000 ryo", "bit 5: continuar"],
    ),
    "en": dict(
        ruta="THE-TEXTS.md", img="imagenes/",
        intro="""# The texts

Ganbare Goemon! only came out in Japanese. Here are all of its texts, taken from the ROM with `tools/textos.py` (`make textos`), each with its address, what asks for it and a translation. **The translation is ours, not Konami's**, and it is not taken from the English translation patch by [MSX Translations](https://msxtranslations.com/goemon.php).

## How they are stored

- **The font.** `letras_del_texto` (`p00:4A6D`) uploads to page 1 of the VDP 0x91 one-bit characters from `0x929D` (bank 14) and 10 more from `0x9725`. Character c lands at x = (c mod 32) × 8, y = (c / 32) × 8 + 0x38 (`p00:491C`), so the first one is 0x20. 0x20 to 0x29 are the digits, 0x2A to 0x2F KONAMI, 0x30 to 0x5D the hiragana in gojūon order (あいうえお かきくけこ...), 0x5E to 0x61 the small っゃゅょ, 0x62 and 0x63 the ゜ and ゛ marks (they come after the character and only advance 4 dots, `p00:490C`), 0x64 to 0x6A punctuation and 両 (ryō), and from 0x6B on pieces of drawings: large letters and frames. There are no loose katakana or kanji.
- **Labels** are drawn in one go (`rotulo`, `p00:48F3`): x, y and the characters; 0xFE moves to another position and 0xFF ends. Each character is an 8 × 8 HMMM copy from page 1.
- **Letter-by-letter texts** (`sigue_texto`, `p00:42F1`): 0xFE is a new line, 0xE0 + n leaves n blanks and 0xFF ends.
- **The ending pieces** start with their length; `texto_del_final` (`p01:653C`) joins them at 0xD800 and they are typed out letter by letter.

«…» in a translation is a blank gap in the label (at the dice table, for instance, the two numbers are drawn there, `p03:B26D`). Labels with drawings are shown as images, drawn with the ROM's own characters in white on black (in the game they take the palette colour of each screen).

## What asks for each label

The table at `p12:A9C0` has 120 pointers; the last six go to `0xB6D2`, where the labels end, so there are 114 (0x00-0x71). They are asked for by `rotulo_numero` (`p00:4280`) and `caja_y_texto` (`p03:B836`) with the number in A. The ROM bytes hold {n4280} calls or jumps to 0x4280 and {nb836} to 0xB836, the same as the listing, and the number each one passes is known: an `ld a` before it, a table or a sum.

- The two nobody asks for are **0x10**, which points to the same text as 0x11, and **0x17** («The shop's closed, sir»); the closed shop uses 0x6F and 0x70 (`p03:AD72`).
- **0x20 to 0x65** come from `texto_al_azar` (`p03:B75E`) in interior 20: 0x20 plus the previous one and a number from 0 to 15 taken from the R register, wrapping at 0x17; at 0x37 if items 3 and 4 of the status bar are held, and at 0x46 if item 0x0A is held as well. So the sayings come first (0x20-0x36), then the hints in verse (0x37-0x56) and last the ones that give away the codes (0x57-0x65).
- At `p12:AFDE`, right after 0x34 and at the height of the next line (y = 0x50), there is a label fragment, «である。» («is.»), that no pointer points to. 0x34 ends with 0xFF before it and stays at three lines.
- In 0x58 to 0x5E the end of the last two lines are characters that make no words (left untranslated). Whether they hide anything has not been looked into.
""",
        h_menus="## The labels in bank 1\n\nThe title, the pause, the password, the neighbour menu and the status bar. Those at 0x640F and 0x641D (each player's name with «はじまり», «start») are never written by anything.",
        h_rotulos="## The 114 labels in the table\n\nInteriors: 0-15 shops, 16 the way into the secret passage, 17 the dice, 18 the inn, 19 the pawnshop that wants the boss's letter, 20 the one who gives advice.",
        h_zona="## Between zones\n\n35 texts (`p15:BC16`), one per zone, typed out by `p02:962F`: the number is stage × 5 + zone − 1.",
        h_fase="## The lord of each stage\n\nSeven texts (`p02:9E0B`), one per stage, typed out by `p02:9B9E`. In stages 0 to 5, if the type 0x21 figure has been hit 8 times or more (0xCD60, `p03:A9D3`), the one at `p02:9F92` comes out instead (see [Findings](FINDINGS.md)).",
        h_final="## The ending\n\nSeven pieces (`p12:BCD3`). `texto_del_final` (`p01:6546`) picks one of four endings by two things: whether the neighbour (Q*bert or the Game Master) is in the other slot (0xEF00) and whether the 7 stages were cleared one by one (0xC26A = 7). Each ending is a list of pieces (`p01:6589`).",
        h_finales="| Ending | Neighbour | 7 stages | Pieces |\n|---|---|---|---|",
        h_pantallas="These are the screens. Each ending is typed out letter by letter from (0x20, 0x10), one letter every 4 frames, with music 0x0D (`p01:62E5`). When the music ends, the screen is cleared and the 16 sprites at `0x65C7` appear: the kanji 終 (\"end\"), in colour 3, with music 0x0F (`p01:62AE`). That last screen is the same in all four endings. Drawn with `tools/finales.py`; the text assembled at 0xD800 was checked by running `p01:653C` with z80run.",
        pie_final="Ending %d", pie_ultima="The last screen",
        h_claves="## The secret words\n\nTwo five-letter words typed during the pause (`p03:BE13`) and four nine-letter codes the password screen accepts (`p03:BE4E`); each sets a bit of 0xEF80. What they do is in [Findings](FINDINGS.md).",
        cols="| | Japanese | Translation | Asked for by |\n|---|---|---|---|",
        cols_r="| No. | Japanese | Translation | Asked for by |\n|---|---|---|---|",
        nadie="nothing", igual="the same text as 0x%02X", si="yes", no="no",
        efecto=["inside the secret passage: bit 0 and the map", "outside: bit 1, +10 ryo with types 8 and 0x21",
                "bit 2: play as player 2", "bit 3: maximum stamina 0x20", "bit 4: 2000 ryo", "bit 5: continue"],
    ),
}


def _celda(t):
    return t.replace("|", "\\|")


def _jp(e, P):
    """La columna japonesa: el texto, o la imagen si el rotulo lleva dibujos."""
    if e.get("imagen"):
        return "![%s](%s%s)" % (e["clave"], P["img"], e["imagen"])
    return _celda(" / ".join(e["lineas"])) if e["lineas"] else ""


def _quien(e, P):
    if e["quien"]:
        return ", ".join("`%s`" % q for q in e["quien"])
    if e.get("igual") is not None:
        return P["nadie"] + " (" + P["igual"] % e["igual"] + ")"
    return P["nadie"]


def imagenes(cart, entradas, docs):
    """Pinta los rotulos con dibujos (sin la marca de opcion ni los vacios)."""
    for e in entradas:
        trozos = [t for t in e.get("trozos") or [] if t[0] is not None and not set(t[1]) & set(X.MARCA)]
        if trozos and X.es_dibujo(trozos) and any(c for _, cs in trozos for c in cs):
            nombre = "texto_%s.png" % e["clave"]
            X.imagen_rotulo(cart, trozos, os.path.join(docs, "imagenes", nombre))
            e["imagen"] = nombre


def pagina(docs):
    cart = G.Cartucho()
    entradas = X.todos(cart)
    imagenes(cart, entradas, docs)
    sitios = X.sitios_que_piden()
    n4280 = sum(1 for s in sitios if s[1] in ("04280h", "rotulo_numero"))
    rutas = []
    for idioma, P in PAGINA.items():
        k = 0 if idioma == "es" else 1
        out = [P["intro"].format(n4280=n4280, nb836=len(sitios) - n4280)]
        grupos = {}
        for e in entradas:
            grupos.setdefault(e["grupo"], []).append(e)

        out.append(P["h_menus"])
        out.append(P["cols"] + "\n" + "\n".join(
            "| `%s` | %s | %s | %s |" % (e["sitio"], _jp(e, P), _celda(T.TRAD[e["clave"]][k]), _quien(e, P))
            for e in grupos["menu"]))

        filas = []
        for e in grupos["rotulo"]:
            num = "0x%02X" % e["n"] if e["n"] is not None else "—"
            filas.append("| %s `%s` | %s | %s | %s |" % (num, e["sitio"], _jp(e, P), _celda(T.TRAD[e["clave"]][k]), _quien(e, P)))
        out.append(P["h_rotulos"])
        out.append(P["cols_r"] + "\n" + "\n".join(filas))

        for grupo, cab in (("zona", "h_zona"), ("fase", "h_fase"), ("final", "h_final")):
            filas = []
            for e in grupos[grupo]:
                num = "%d" % e["n"] if e["n"] is not None else "—"
                filas.append("| %s `%s` | %s | %s | %s |" % (num, e["sitio"], _jp(e, P), _celda(T.TRAD[e["clave"]][k]), _quien(e, P)))
            out.append(P[cab])
            out.append(P["cols_r"] + "\n" + "\n".join(filas))
        filas = []
        for f, trozos in enumerate(X.finales(cart)):
            filas.append("| %d | %s | %s | %s |" % (f, P["si"] if f & 2 else P["no"], P["si"] if f & 1 else P["no"],
                                                    ", ".join(str(t) for t in trozos)))
        out.append(P["h_finales"] + "\n" + "\n".join(filas))
        out.append(P["h_pantallas"])
        for f in range(4):
            out.append("**%s**\n\n![final_%d](%sfinal_%d.png)" % (P["pie_final"] % f, f, P["img"], f))
        out.append("**%s**\n\n![final_sprites](%sfinal_sprites.png)" % (P["pie_ultima"], P["img"]))

        filas = []
        for i, e in enumerate(grupos["clave"]):
            filas.append("| `%s` | %s | %s | %s |" % (e["sitio"], _jp(e, P), _celda(T.TRAD[e["clave"]][k]), P["efecto"][i]))
        out.append(P["h_claves"])
        out.append(P["cols"].replace("Lo pide", "Qué hace").replace("Asked for by", "What it does") + "\n" + "\n".join(filas))

        ruta = os.path.join(docs, P["ruta"])
        with open(ruta, "w", encoding="utf-8", newline="\n") as f:
            f.write("\n\n".join(out) + "\n")
        rutas.append(ruta)
        print(ruta)
    return rutas
