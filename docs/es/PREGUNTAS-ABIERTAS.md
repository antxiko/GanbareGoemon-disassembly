# Preguntas abiertas

Lo que el listado dice pero aún no se ha visto en el emulador, y lo que no se
sabe.

## Leído en el código, sin ver en openMSX

Los 10 ryo de すきやねん, «continuar» al cambiar la cosa 3, los ocho golpes al
tipo 0x21, los bloques de 50 ryo, los dados y los cuatro finales. Todos están
en [Hallazgos](HALLAZGOS.md), con su dirección; ninguno se ha probado jugando.

## La cosa 14

Tiene precio en la tabla y su rutina es la de las vidas (p03:AEB2). Esa rutina
suma B de vida: las cosas 11 y 12 ponen B a 16 y a 8 antes de llegar, pero la
14 entra directa con lo que valga B. Como ninguna tienda la vende, no se sabe
cuánto daría.

## La figura 0x1B

No sale en las listas de las casillas y no se ha encontrado quién la crea. Las
0x12 y 0x1D son de la escena del final de fase, pero de la 0x1B no se sabe.

## La música 0x9C

Tiene entrada en la tabla, pero su primer puntero va al silencio y detrás ya
empieza el efecto 0x20 (0x663A). Falta saber si algo la pide.

## La tabla que se ejecuta

Si una tienda no tiene nada a la venta, el `djnz` de p03:ADB2 cae en la tabla
de p03:ADB4 y la ejecuta como código. No se ha visto qué hace entonces.

## Los pasadizos de cada zona

Aparte de los pasadizos secretos, el juego tiene otros pasadizos (0xC483,
banco 15: sus huecos y sus piezas). Están en el listado, pero aún no se han
dibujado.
