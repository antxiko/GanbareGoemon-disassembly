#!/usr/bin/env python3
"""La musica del cartucho, ejecutando su motor de sonido (ver motor_musica.py).

Primero `sonido_a_cero` (p00:4FB5), que deja la mezcla del PSG en 0xBC; luego
`sonido` (p00:4FE4, A = 0x80 + n la musica n, 1-0x7F un efecto, 0 calla) y, cada
cuadro, `sonido_del_cuadro` (p10:6000, con los bancos 10, 11 y 12 en 0x6000,
0x8000 y 0xA000), como hace la interrupcion (p00:405A). La RAM del sonido es
0xC010-0xC0B3. MegaROM Konami4 de 128 KB, MSX2, sin SCC.
Uso:  musica.py registros 0x82 [cuadros] | mp3 0x82 f.mp3 | todas docs/audio
      musica.py barrido 0x80 0xA0 | emu | python tools/unicas.py 0x80 0xA0
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import motor_musica  # noqa: E402
from motor_musica import P  # noqa: E402

PIEZAS = [
    P(0x88, "El pasadizo", "The secret passage", "`pasadizo`"),
    P(0x8C, "La zona", "The zone", "`estado_8`"),
    P(0x8F, "El final", "The ending", "`estado_0f`"),
    P(0x8A, "La pieza del 0x6120", "The tune at 0x6120", "`L_6120`"),
    P(0x8B, "Cae al hoyo", "Falling into the hole", "`cae_al_hoyo`"),
    P(0x8D, "La pieza del 0x62E5", "The tune at 0x62E5", "`L_62E5`"),
    P(0x8E, "La pieza del 0x5F7E", "The tune at 0x5F7E", "`L_5F7E`"),
    P(0x90, "La pieza del 0x7C25", "The tune at 0x7C25", "`L_7C25`"),
    P(0x81, "La pieza del 0x925D", "The tune at 0x925D",
      "`L_925D` y `L_B508`"),
] + [P(n, "Pista 0x%02X de la tabla" % n, "Table track 0x%02X" % n,
       "ninguna llamada directa: sale de la tabla de música por un número "
       "calculado")
     for n in (0x82, 0x83, 0x84, 0x85, 0x86, 0x87, 0x91)]

PAGINA = motor_musica.pagina_basica(
    "`sonido_del_cuadro`, p10:6000, y `sonido`, p00:4FE4, que apunta las "
    "partituras; la interrupción lo llama en p00:405A con los bancos 10, 11 y 12",
    "`sonido_del_cuadro`, p10:6000, and `sonido`, p00:4FE4, which writes the "
    "scores; the interrupt calls it at p00:405A with banks 10, 11 and 12",
    "C-BIOS MSX2 japonés",
    [("la pieza 0x82, sus primeros 495 cuadros",
      "tune 0x82, its first 495 frames"),
     ("la pieza 0x8D, sus primeros 494 cuadros",
      "tune 0x8D, its first 494 frames")],
    [("Cómo se pide una pieza",
      "`sonido` recibe el número en A: 0x80 + n es la música n, del 1 al "
      "0x7F un efecto, 0 lo calla todo y del 0xFD en adelante son órdenes "
      "(pausa, sigue, fundido). Mete los bancos 10, 11 y 12 y apunta las "
      "tres partituras de la música (seis bytes por música, tabla de "
      "p10:6592). Antes se corre `sonido_a_cero`, que deja la copia del "
      "mezclador del PSG en 0xBC. La RAM del sonido está en 0xC010-0xC0B3. "
      "Las pistas «de la tabla» salen de ella por un número calculado; las "
      "que suenan igual que otra se publican una vez.",
      "How a piece is asked for",
      "`sonido` takes the number in A: 0x80 + n is music n, 1 to 0x7F an "
      "effect, 0 silences everything and from 0xFD up are orders (pause, "
      "resume, fade). It maps banks 10, 11 and 12 and points the music's "
      "three scores (six bytes per tune, table at p10:6592). Before that, "
      "`sonido_a_cero` runs, leaving the copy of the PSG mixer at 0xBC. The "
      "sound RAM is at 0xC010-0xC0B3. The tracks marked «in the table» come "
      "out of it by a computed number; those that sound like another are "
      "published once.")])

CFG = dict(rom="goemon.rom", org=0x4000, mapper="konami",
           bancos0=((0x4000, 0), (0x6000, 10), (0x8000, 11), (0xA000, 12)),
           bancos_frame=((0x6000, 10), (0x8000, 11), (0xA000, 12)),
           init=[(0x4FB5, {})], frame=0x6000, pide=0x4FE4,
           banco_frame=10, banco_pide=0, ram=(0xC010, 0xC0B4), hz=60,
           psg0={7: 0xBC}, romtype="konami", maquina="C-BIOS_MSX2_JP",
           max_s=75, piezas=PIEZAS, pagina=PAGINA,
           cotejado=[(0x82, 2881, 1537), (0x8D, 1154, None)])

if __name__ == "__main__":
    sys.exit(motor_musica.main(CFG, sys.argv[1:]))
