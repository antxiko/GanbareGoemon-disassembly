# La música

Todo lo que suena aquí sale de ejecutar el motor de sonido del cartucho (`sonido_del_cuadro`, p10:6000, y `sonido`, p00:4FE4, que apunta las partituras; la interrupción lo llama en p00:405A con los bancos 10, 11 y 12) en un Z80 emulado, cuadro a cuadro y a 60 por segundo, igual que lo llama el juego. Lo que el motor escribe en el PSG pasa a sonido con un AY-3-8910 (`tools/musica.py`). Cada MP3 es la pieza entera hasta donde vuelve a empezar, más 8 segundos de la vuelta apagándose; las que no se repiten acaban donde acaba el motor.

## Cotejado con openMSX

Las escrituras al PSG se han comparado cuadro a cuadro con las de openMSX (C-BIOS MSX2 japonés). En todos los cuadros el PSG queda igual:

- la pieza 0x82, sus primeros 495 cuadros;
- la pieza 0x8D, sus primeros 494 cuadros.

El timbre no está cotejado: es el de un AY-3-8910 de manual, no una grabación del emulador. Las sondas están en `tools/omsx_psg.tcl` y `tools/coteja_psg.py`.

## Cómo se pide una pieza

`sonido` recibe el número en A: 0x80 + n es la música n, del 1 al 0x7F un efecto, 0 lo calla todo y del 0xFD en adelante son órdenes (pausa, sigue, fundido). Mete los bancos 10, 11 y 12 y apunta las tres partituras de la música (seis bytes por música, tabla de p10:6592). Antes se corre `sonido_a_cero`, que deja la copia del mezclador del PSG en 0xBC. La RAM del sonido está en 0xC010-0xC0B3. Las pistas «de la tabla» salen de ella por un número calculado; las que suenan igual que otra se publican una vez.

## Las músicas

**El pasadizo** (0x88)

Lo pide `pasadizo`; dura 21,4 s y vuelve a empezar en el segundo 4,3.

<audio controls preload="none" src="../audio/musica_88.mp3?v=41d1a966"></audio>

**La zona** (0x8C)

Lo pide `estado_8`; dura 7,3 s.

<audio controls preload="none" src="../audio/musica_8C.mp3?v=813b66f7"></audio>

**El final** (0x8F)

Lo pide `estado_0f`; dura 3,5 s.

<audio controls preload="none" src="../audio/musica_8F.mp3?v=eb80f5b7"></audio>

**La pieza del 0x6120** (0x8A)

Lo pide `L_6120`; dura 9,2 s.

<audio controls preload="none" src="../audio/musica_8A.mp3?v=1de00dd4"></audio>

**Cae al hoyo** (0x8B)

Lo pide `cae_al_hoyo`; dura 3,4 s.

<audio controls preload="none" src="../audio/musica_8B.mp3?v=f9b9b3ff"></audio>

**La pieza del 0x62E5** (0x8D)

Lo pide `L_62E5`; dura 19,2 s.

<audio controls preload="none" src="../audio/musica_8D.mp3?v=03454b5d"></audio>

**La pieza del 0x5F7E** (0x8E)

Lo pide `L_5F7E`; dura 3,4 s.

<audio controls preload="none" src="../audio/musica_8E.mp3?v=a7395ead"></audio>

**La pieza del 0x7C25** (0x90)

Lo pide `L_7C25`; dura 1,7 s.

<audio controls preload="none" src="../audio/musica_90.mp3?v=8e46a979"></audio>

**La pieza del 0x925D** (0x81)

Lo pide `L_925D` y `L_B508`; dura 25,8 s y vuelve a empezar en el segundo 8,7.

<audio controls preload="none" src="../audio/musica_81.mp3?v=036bd974"></audio>

**Pista 0x82 de la tabla** (0x82)

Lo pide ninguna llamada directa: sale de la tabla de música por un número calculado; dura 48,0 s y vuelve a empezar en el segundo 25,6.

<audio controls preload="none" src="../audio/musica_82.mp3?v=27baab89"></audio>

**Pista 0x83 de la tabla** (0x83)

Lo pide ninguna llamada directa: sale de la tabla de música por un número calculado; dura 44,8 s y vuelve a empezar en el segundo 22,4.

<audio controls preload="none" src="../audio/musica_83.mp3?v=be86309e"></audio>

**Pista 0x84 de la tabla** (0x84)

Lo pide ninguna llamada directa: sale de la tabla de música por un número calculado; dura 57,6 s y vuelve a empezar en el segundo 28,8.

<audio controls preload="none" src="../audio/musica_84.mp3?v=fb0a38ec"></audio>

**Pista 0x85 de la tabla** (0x85)

Lo pide ninguna llamada directa: sale de la tabla de música por un número calculado; dura 38,4 s y vuelve a empezar en el segundo 16,0.

<audio controls preload="none" src="../audio/musica_85.mp3?v=8d205ab3"></audio>

**Pista 0x86 de la tabla** (0x86)

Lo pide ninguna llamada directa: sale de la tabla de música por un número calculado; dura 48,0 s y vuelve a empezar en el segundo 24,0.

<audio controls preload="none" src="../audio/musica_86.mp3?v=a2ef6919"></audio>

**Pista 0x87 de la tabla** (0x87)

Lo pide ninguna llamada directa: sale de la tabla de música por un número calculado; dura 54,0 s y vuelve a empezar en el segundo 19,4.

<audio controls preload="none" src="../audio/musica_87.mp3?v=10f5feb2"></audio>

**Pista 0x91 de la tabla** (0x91)

Lo pide ninguna llamada directa: sale de la tabla de música por un número calculado; dura 27,2 s y vuelve a empezar en el segundo 10,2.

<audio controls preload="none" src="../audio/musica_91.mp3?v=723f548e"></audio>
