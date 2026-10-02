# El cartucho

| | |
|---|---|
| título | *Ganbare Goemon! Karakuri Dōchū* (Konami, 1987) |
| número | RC-748 |
| máquina | MSX2 (V9938), SCREEN 5 |
| tamaño | 131.072 bytes: 16 bancos de 8 KB |
| mapper | Konami sin SCC (Konami4) |
| sonido | PSG, tres canales |
| sha256 | `a436addc241d977ba38081463322e7e611d6bab4d10cd06305fe5a71f02a549c` |

La cabecera es `AB` con INIT en 0x4097, y la interrupción entra en 0x4045 por
H.TIMI. En 0x4010 hay una segunda cabecera, `CD`, que es la que busca el Game
Master.

## El mapper

El banco 0 está **fijo** en 0x4000-0x5FFF. Los otros tres huecos se eligen
escribiendo el número de banco en 0x6000, 0x8000 y 0xA000. No hay ni una
escritura a 0x5000, 0x7000, 0x9000 ni 0xB000, que son los registros del mapper
con SCC: por eso es Konami4.

Hay **49 escrituras** al mapper (`tools/reconocimiento.py`): 8 a 0x6000, 10 a
0x8000 y 31 a 0xA000. Los bancos se cargan de tres en tres con cinco rutinas,
p00:4206, 4220, 4238, 4250 y 4268 (1-2-3, 4-5-6, 7-8-9, 10-11-12 y 13-14-15).
Con eso, cada banco tiene su hueco y el listado se parte en dieciséis módulos,
cada uno con su `org`:

| hueco | bancos |
|---|---|
| 0x4000 (fijo) | 0 |
| 0x6000 | 1, 4, 7, 10, 13 |
| 0x8000 | 2, 5, 8, 11, 14 |
| 0xA000 | 3, 6, 9, 12, 15 |

Hay **una excepción**: p01:7DEC pone el banco 14 en 0xA000 para leer las cosas
de cada casilla, y el listado la declara (`tools/paginas.py`). De las 31
escrituras a 0xA000, **21 son sueltas**: rutinas que leen una tabla y cambian
solo ese hueco (al banco 6, 9, 12, 14 o 15). Veinte vuelven al trío 1-2-3 al
acabar. La otra, p01:7DA1, sale antes si la zona no tiene salidas especiales:
en 14 zonas deja el banco 9 puesto hasta la siguiente vuelta al trío, sin que
se note (las 14 coinciden con openMSX). La interrupción llama al sonido con
los bancos 10, 11 y 12 (p00:404F) y al salir los devuelve desde sus copias en
RAM (0xF0F1-0xF0F3).

## Qué hay en cada banco

| banco | código | qué lleva |
|---|---|---|
| 0 | 6.703 B | el arranque, la interrupción, los estados del juego, los lectores de datos (rle, dibujos, letras, HMMC, paletas, rótulos), el montaje y la pintada de la pantalla, el marcador; las listas de color de las figuras |
| 1 | 7.439 B | la partida: la carga de la zona, el jugador y sus choques, la pausa, la contraseña, los finales; las marcas del Game Master y de Q\*bert, el guion de la demo |
| 2 | 6.087 B | las figuras (crear, mover, sus sprites), los interiores y sus precios (0x9371), los pasadizos, el final de fase y sus textos |
| 3 | 7.181 B | cada tipo de figura, las compras, los dados, los pasadizos secretos, las palabras de la pausa y las claves; la marca de Konami |
| 4, 5 | — | los caracteres de los seis juegos de gráficos, en rle |
| 6 | — | los enlaces de las 49 zonas, las tablas del teclado, el dibujo del título |
| 7 | — | los dibujos que comparten todos los juegos y los del marcador |
| 8 | — | los sprites de las 20 poses de Goemon y de Ebisumaru |
| 9 | — | las salidas de cada zona, los pasadizos secretos (0xA575 y 0xA86D), las paletas, las poses de las figuras, el juego de gráficos de cada zona (0xB8EC) y el dinero de cada tipo (0xB86D) |
| 10 | 1.314 B | el **sonido**: 28 músicas y 32 efectos, y la rutina que lo toca |
| 11 | — | dibujos de figuras, los 9 instrumentos y el final de una partitura del banco 10 |
| 12 | — | 114 rótulos (0xA9C0), las fichas de figura (0xA830) y de pose, las frases del final (0xBCD3) |
| 13 | — | las rejillas de las 49 zonas, las pantallas y los bloques de cada juego |
| 14 | — | qué figuras salen en cada casilla (0x9BF0), las cosas de cada casilla (0x981D), más bloques |
| 15 | — | las cosas fijas (0xA08E), los pasadizos de cada zona, los textos al pasar una zona (0xBC16) |

En total, **28.724 bytes de código y 102.348 de datos**: el 100 % del cartucho
asignado (`make sanity`).

## La VRAM

El juego corre en **SCREEN 5** (p00:4994), con 16 colores de una paleta de
512.

- **La página 1** es el almacén: cada zona sube ahí sus caracteres de 8 × 8 a
  4 bits, y el carácter k queda en x = (k % 32) × 8, y = (k / 32) × 8
  (p00:4976).
- **La página 0** es la pantalla. La casilla se monta en 0xD800 y se pinta
  desde la línea 0x20, un HMMM por carácter (p00:534E). Las cosas fijas se
  copian encima con LMMM y transparencia (p02:90C0).

Los sprites son de **modo 2** (16 × 16, color por línea). Sus dibujos van a
0xF800. La tabla y los colores se rehacen en RAM (0xEE00 y 0xEC80) y p01:685F
los copia en los cuadros impares. Por eso un volcado puede pillar la copia de
un cuadro antes, y los cotejos lo tienen en cuenta.

## La RAM que importa

| dirección | qué es |
|---|---|
| 0xC000 / 0xC001 | el estado del juego y su paso |
| 0xC002 | banderas de la partida (bit 7 jugador 2, bit 6 en juego) |
| 0xC00B / 0xC00C | F1-F3 recién apretadas |
| 0xC257 | los puntos (BCD) |
| 0xC260 | las vidas |
| 0xC265-0xC266 | el dinero, en BCD |
| 0xC270-0xC27D | las cosas del marcador |
| 0xC27F | se puede continuar |
| 0xC280 / 0xC281 / 0xC288 | la zona, la casilla y la fase |
| 0xC289 | el juego de gráficos de la zona |
| 0xC480 / 0xC481 | la vida máxima y la vida |
| 0xC4B0 | el tiempo (BCD) |
| 0xC600 | las 8 figuras, 0x80 bytes cada una |
| 0xCDB1 | se está en un pasadizo secreto |
| 0xEF00 | 0xFF si está el vecino |
| 0xEF80 | los secretos: bits 0-1 las palabras, 2-5 las claves, 6 el menú |
