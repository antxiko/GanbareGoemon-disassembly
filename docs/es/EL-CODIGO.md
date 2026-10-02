# El código

## Todo corre en la interrupción

INIT (0x4097) borra la RAM del juego (0xC000-0xF0EF), busca al vecino en las
otras ranuras (p01:7EAB), pasa a SCREEN 5 y engancha H.TIMI. Desde ahí el
programa principal se queda en un `jr` sobre sí mismo (p00:40E5), y todo el
juego corre en **p00:4045**, una vez por cuadro:

1. Si está el vecino, primero la pausa de STOP (p00:40E7, 0xEF01).
2. El sonido, con los bancos 10, 11 y 12 puestos (p10:6000). Luego vuelven los
   bancos del juego desde 0xF0F1-0xF0F3.
3. Si el cuadro anterior ya acabó (el semáforo de 0xC005), la **máquina de
   estados** (p00:5DBB). La interrupción se abre antes, para que el sonido no
   espere al juego.

## El despachador

p00:408D es el despachador de Konami: la tabla de destinos va **pegada detrás
del `call`**. Saca de la pila la dirección de vuelta, que es la base de la
tabla, y salta al destino número A. El listado marca cada una de esas tablas
como datos y nombra sus destinos.

## Los estados del juego

0xC000 es el estado y 0xC001 su paso (tabla de 0x5DCF):

| estado | qué es |
|---|---|
| 0 | el logotipo de Konami y el título |
| 1 | el menú del título |
| 2 | la demostración |
| 3 | empieza la partida |
| 4 | la entrada en la zona |
| 5 | el juego |
| 6 | se pierde una vida |
| 7 | sin vidas: continuar o se acabó |
| 8 | la zona pasada: el tiempo a puntos y la zona siguiente |
| 9 | se sale de la casilla |
| 0x0A | la pausa |
| 0x0B | la fase pasada |
| 0x0C | el menú del vecino |
| 0x0D | F2 en la pausa: la contraseña |
| 0x0E | la pantalla de la contraseña |
| 0x0F | el final del juego |

En los estados 0 a 2, cualquier tecla lleva al título (p01:62FE).

## El jugador

p01:6D38 lleva al jugador un cuadro: lee los mandos y despacha por su estado
(0xC490, tabla de 0x6D4C), donde 0 es en el suelo, 1 saltando y 2 muriendo.
Los mandos van a 0xC006/0xC007 y F1-F3 a 0xC00B/0xC00C (p00:49D2). p01:781F
dice si el jugador puede estar en un sitio: da carry si **no** puede.

## Una casilla

Al entrar en una casilla, p01:66F6 hace por orden:

1. sus enlaces y sus salidas especiales;
2. borra las figuras;
3. monta la pantalla en 0xD800 (p00:51ED) y la pinta (p00:534E);
4. encima, las cosas fijas (p02:90C0);
5. pone al jugador en el punto de entrada;
6. sube los dibujos de las figuras de la casilla (p00:5413);
7. pinta el marcador y pone los colores.

## Las figuras

Hay 8 figuras en 0xC600, de 0x80 bytes cada una: tipo (ix+0), paso (ix+1), y
(ix+3), x (ix+5), pose (ix+0x0A)… p02:8334 crea una en el primer hueco libre.
Cada tipo tiene dos entradas en sus tablas: la de arranque (p02:8427) y la de
cada cuadro (p02:871C), y esta despacha a su vez por el paso de la figura. Sus
sprites salen de la pose (0xB6D2) y sus colores de las listas de 0x554E.

## Los pasadizos secretos

p00:5969 monta el de la zona en 0xD800, un byte por casilla y 28 por fila, a
partir de una rejilla de bits (1 pared, 0 paso) y unas marcas encima
(p00:5A10). Mientras se está dentro, 0xCDB1 no es cero, y cada cuadro va a
p02:9881: andar (p03:B8C3), coger lo que haya (p03:BC5C), el mapa (p03:BAF1)
o la salida (p03:BD06).

## El sonido

Todo está en el banco 10, y lo llama la interrupción en cada cuadro. Hay **28
músicas** (0x6592, seis bytes cada una: un puntero por canal del PSG) y **32
efectos** (0x6550). p10:61F1 lee las partituras: notas, silencios, tiempo,
octava, saltos y órdenes 0xD0-0xFF (p10:6341). El tono de cada nota sale de la
octava más grave (0x6303). Los 9 instrumentos y el final de una partitura
están en el banco 11. Hay una música 0x9C a medias, con el primer puntero al
silencio, y detrás ya empieza el efecto 0x20 (0x663A).

## Cómo está hecho el listado

- `tools/bancos.py` traza **el cartucho entero** llevando la cuenta de qué
  banco hay en cada hueco. De ahí salen las llamadas que cruzan el mapper
  (`src/pNN.entries`) y las tablas del despachador (`src/pNN.nocode`).
- `tools/z80trace.py` sigue el flujo de cada banco desde esas entradas.
- `tools/bloques.py` declara los datos recorriéndolos como los lectores del
  banco 0 (rle, dibujos, letras, HMMC, paletas, rótulos).
- `src/pNN.notes` guarda las etiquetas, los comentarios y los rangos de datos,
  anclados a dirección. `tools/mkasm.py` los mezcla con el trazado y escribe
  `src/goemon_pNN.asm`.
- `make verify` reensambla los dieciséis bancos con Pasmo y la ROM entera, y
  compara los sha256.
- `make sanity` comprueba que ningún dato se lea como código y que no quede ni
  un byte sin asignar.

La densidad: **42,5 %** de las 14.355 instrucciones llevan comentario, y las
1.678 rutinas pasan todas del 10 % (`make densidad`).
