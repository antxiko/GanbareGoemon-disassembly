# The music

Everything you hear here comes from running the cartridge's own sound engine (`sonido_del_cuadro`, p10:6000, and `sonido`, p00:4FE4, which writes the scores; the interrupt calls it at p00:405A with banks 10, 11 and 12) on an emulated Z80, frame by frame at 60 per second, just as the game calls it. What the engine writes to the PSG is turned into sound with an AY-3-8910 (`tools/musica.py`). Each MP3 is the whole piece up to where it starts again, plus 8 seconds of the repeat fading out; those that do not repeat end where the engine ends.

## Checked against openMSX

The PSG writes have been compared frame by frame with those of openMSX (C-BIOS MSX2 japonés). In every frame the PSG ends up the same:

- tune 0x82, its first 495 frames;
- tune 0x8D, its first 494 frames.

The timbre is not checked: it is a textbook AY-3-8910, not a recording of the emulator. The probes are `tools/omsx_psg.tcl` and `tools/coteja_psg.py`.

## How a piece is asked for

`sonido` takes the number in A: 0x80 + n is music n, 1 to 0x7F an effect, 0 silences everything and from 0xFD up are orders (pause, resume, fade). It maps banks 10, 11 and 12 and points the music's three scores (six bytes per tune, table at p10:6592). Before that, `sonido_a_cero` runs, leaving the copy of the PSG mixer at 0xBC. The sound RAM is at 0xC010-0xC0B3. The tracks marked «in the table» come out of it by a computed number; those that sound like another are published once.

## The tunes

**The secret passage** (0x88)

Asked for by `pasadizo`; lasts 21.4 s and starts again at second 4.3.

<audio controls preload="none" src="audio/musica_88.mp3?v=41d1a966"></audio>

**The zone** (0x8C)

Asked for by `estado_8`; lasts 7.3 s.

<audio controls preload="none" src="audio/musica_8C.mp3?v=813b66f7"></audio>

**The ending** (0x8F)

Asked for by `estado_0f`; lasts 3.5 s.

<audio controls preload="none" src="audio/musica_8F.mp3?v=eb80f5b7"></audio>

**The tune at 0x6120** (0x8A)

Asked for by `L_6120`; lasts 9.2 s.

<audio controls preload="none" src="audio/musica_8A.mp3?v=1de00dd4"></audio>

**Falling into the hole** (0x8B)

Asked for by `cae_al_hoyo`; lasts 3.4 s.

<audio controls preload="none" src="audio/musica_8B.mp3?v=f9b9b3ff"></audio>

**The tune at 0x62E5** (0x8D)

Asked for by `L_62E5`; lasts 19.2 s.

<audio controls preload="none" src="audio/musica_8D.mp3?v=03454b5d"></audio>

**The tune at 0x5F7E** (0x8E)

Asked for by `L_5F7E`; lasts 3.4 s.

<audio controls preload="none" src="audio/musica_8E.mp3?v=a7395ead"></audio>

**The tune at 0x7C25** (0x90)

Asked for by `L_7C25`; lasts 1.7 s.

<audio controls preload="none" src="audio/musica_90.mp3?v=8e46a979"></audio>

**The tune at 0x925D** (0x81)

Asked for by `L_925D` y `L_B508`; lasts 25.8 s and starts again at second 8.7.

<audio controls preload="none" src="audio/musica_81.mp3?v=036bd974"></audio>

**Table track 0x82** (0x82)

Asked for by ninguna llamada directa: sale de la tabla de música por un número calculado; lasts 48.0 s and starts again at second 25.6.

<audio controls preload="none" src="audio/musica_82.mp3?v=27baab89"></audio>

**Table track 0x83** (0x83)

Asked for by ninguna llamada directa: sale de la tabla de música por un número calculado; lasts 44.8 s and starts again at second 22.4.

<audio controls preload="none" src="audio/musica_83.mp3?v=be86309e"></audio>

**Table track 0x84** (0x84)

Asked for by ninguna llamada directa: sale de la tabla de música por un número calculado; lasts 57.6 s and starts again at second 28.8.

<audio controls preload="none" src="audio/musica_84.mp3?v=fb0a38ec"></audio>

**Table track 0x85** (0x85)

Asked for by ninguna llamada directa: sale de la tabla de música por un número calculado; lasts 38.4 s and starts again at second 16.0.

<audio controls preload="none" src="audio/musica_85.mp3?v=8d205ab3"></audio>

**Table track 0x86** (0x86)

Asked for by ninguna llamada directa: sale de la tabla de música por un número calculado; lasts 48.0 s and starts again at second 24.0.

<audio controls preload="none" src="audio/musica_86.mp3?v=a2ef6919"></audio>

**Table track 0x87** (0x87)

Asked for by ninguna llamada directa: sale de la tabla de música por un número calculado; lasts 54.0 s and starts again at second 19.4.

<audio controls preload="none" src="audio/musica_87.mp3?v=10f5feb2"></audio>

**Table track 0x91** (0x91)

Asked for by ninguna llamada directa: sale de la tabla de música por un número calculado; lasts 27.2 s and starts again at second 10.2.

<audio controls preload="none" src="audio/musica_91.mp3?v=723f548e"></audio>
