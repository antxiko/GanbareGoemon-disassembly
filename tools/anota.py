#!/usr/bin/env python3
"""Anota lo que ya esta identificado: rutinas con nombre, RAM y cambios de banco.

Una vez se sabe que 0xC281 es la casilla no tiene merito -ni fiabilidad-
escribir a mano "la casilla" las cincuenta veces que aparece. Esto lo hace
de una vez y sin equivocarse, en una seccion delimitada de src/pNN.notes que
reescribe entera cada vez.

- RUTINAS: el nombre de cada rutina (directiva L) y, en cada `call`/`jp` que
  va a ella, un comentario con lo que hace.
- RAM: en cada instruccion que nombra una direccion de la tabla, que es.
- Los cambios de banco (`ld (0x6000/0x8000/0xA000),a` con un `ld a,N` o un
  `inc a` delante) y las copias en 0xF0F1-0xF0F3.

CADA ENTRADA LLEVA DE DONDE SALE. Lo que no se sabe no esta en la tabla.
Donde ya hay un comentario escrito a mano no se pone otro.

Uso: anota.py              informa de cuantos pondria
     anota.py --escribe    y los escribe
"""
import os
import re
import sys

AQUI = os.path.dirname(os.path.abspath(__file__))
RAIZ = os.path.dirname(AQUI)
sys.path.insert(0, AQUI)

from paginas import ORG                                    # noqa: E402

BANCOS = (0, 1, 2, 3, 10)
INI = "# --- ANOTACIONES AUTOMATICAS (seccion que reescribe tools/anota.py; no editar a mano) ---"
FIN = "# --- fin de las anotaciones de anota.py ---"

# (banco, direccion) -> (nombre, lo que hace). Cada una leida en el listado.
RUTINAS = {
    (0, 0x4045): ("interrupcion", "cada cuadro, por H.TIMI: el sonido (banco 10 en 0x6000) y el juego"),
    (0, 0x4083): ("hl_mas_a", "HL += A"),
    (0, 0x4088): ("de_mas_a", "DE += A"),
    (0, 0x408D): ("despacha", "salta a la entrada A de la tabla que va detras del call"),
    (0, 0x4097): ("init", "arranque del cartucho"),
    (0, 0x4129): ("calla_y_guarda", "guarda los volumenes del PSG (registros 8-10) en 0xEF11-0xEF13 y los pone a cero"),
    (0, 0x4141): ("calla_el_psg", "los tres volumenes del PSG a cero"),
    (0, 0x4154): ("devuelve_volumen", "vuelve a poner los volumenes guardados en 0xEF11-0xEF13"),
    (0, 0x416F): ("musica_de_la_zona", "la musica del juego de graficos de la zona (tabla 0x4182)"),
    (0, 0x4188): ("enlaces_de_la_zona", "copia los enlaces entre casillas de la zona a 0xE780"),
    (0, 0x41F6): ("indice_de_la_zona", "A = (fase * 7 + zona) * 2"),
    (0, 0x4206): ("bancos_1_2_3", "pone los bancos 1, 2 y 3"),
    (0, 0x4220): ("bancos_4_5_6", "pone los bancos 4, 5 y 6"),
    (0, 0x4238): ("bancos_7_8_9", "pone los bancos 7, 8 y 9"),
    (0, 0x4250): ("bancos_10_11_12", "pone los bancos 10, 11 y 12"),
    (0, 0x4268): ("bancos_13_14_15", "pone los bancos 13, 14 y 15"),
    (0, 0x4280): ("rotulo_numero", "pinta el rotulo A de la tabla de 0xA9C0 (banco 12)"),
    (0, 0x4295): ("pantallas_de_la_zona", "descomprime las pantallas de la zona a 0xD000"),
    (0, 0x42AC): ("bloques_de_la_zona", "descomprime los bloques de la zona a 0xE100"),
    (0, 0x42C3): ("rle_a_la_ram", "descomprime un rle a la RAM"),
    (0, 0x42E1): ("empieza_texto", "empieza un texto letra a letra: HL el texto, DE el sitio (0xCD61-0xCD67)"),
    (0, 0x42F1): ("sigue_texto", "saca la letra siguiente del texto de 0xCD65 (0xFF acaba)"),
    (0, 0x4351): ("empieza_la_partida", "la RAM de la partida a cero desde 0xC25A, y vidas de 0x437B"),
    (0, 0x437E): ("suma_puntos", "suma puntos en BCD al jugador que juega"),
    (0, 0x43E2): ("pinta_el_marcador", "pinta el marcador entero"),
    (0, 0x4406): ("pinta_los_puntos", "pinta los puntos"),
    (0, 0x4418): ("pinta_las_vidas", "pinta las vidas"),
    (0, 0x4420): ("pinta_bcd", "pinta cifras en BCD"),
    (0, 0x4449): ("intercambia", "intercambia los bytes de (HL) y (DE)"),
    (0, 0x447C): ("palabra_de_tabla_de", "DE = la palabra A de la tabla de DE"),
    (0, 0x44B1): ("copia_a_la_vram", "copia bytes de la RAM a la VRAM"),
    (0, 0x44C4): ("rellena_la_vram", "llena un tramo de la VRAM con un byte"),
    (0, 0x44F7): ("vram_para_escribir", "prepara el V9938 para escribir en la VRAM"),
    (0, 0x4533): ("rle_con_destino", "descomprime a la VRAM un rle que lleva el destino delante"),
    (0, 0x4539): ("rle_a_la_vram", "descomprime un rle a la VRAM"),
    (0, 0x455C): ("rle_vuelto_con_destino", "como 0x4562, con el destino delante del rle"),
    (0, 0x4562): ("rle_vuelto", "descomprime un rle a la VRAM de HL pasando por 0xDD10"),
    (0, 0x45C0): ("bits_al_reves", "da la vuelta a los bits de A"),
    (0, 0x45D3): ("borra_la_pantalla", "borra la pantalla"),
    (0, 0x45E1): ("enciende_la_pantalla", "bit 6 del registro 1 del VDP a uno"),
    (0, 0x45EE): ("apaga_la_pantalla", "bit 6 del registro 1 del VDP a cero"),
    (0, 0x460A): ("esconde_los_sprites", "y = 0xE0 a los 32 sprites de la VRAM (0xF600 y 0x7600) y de la RAM"),
    (0, 0x4626): ("sprites_fuera", "apaga los sprites (bit 1 del registro 8 del VDP)"),
    (0, 0x4631): ("sprites_dentro", "enciende los sprites (bit 1 del registro 8 del VDP a cero)"),
    (0, 0x463C): ("pon_un_color", "color A de la paleta = DE"),
    (0, 0x4666): ("pon_paleta", "pone una lista de colores en la paleta"),
    (0, 0x4674): ("espera_al_vdp", "espera a que el V9938 acabe la orden"),
    (0, 0x467D): ("lee_estado_del_vdp", "lee un registro de estado del V9938"),
    (0, 0x469D): ("linea_horizontal", "pinta una linea horizontal"),
    (0, 0x46D0): ("linea_vertical", "pinta una linea vertical"),
    (0, 0x4704): ("marco", "pinta un marco"),
    (0, 0x4732): ("hmmv", "orden HMMV del V9938: rellena un rectangulo"),
    (0, 0x476E): ("hmmm", "orden HMMM del V9938: copia un rectangulo de VRAM a VRAM"),
    (0, 0x47B2): ("hmmc", "orden HMMC del V9938: puntos de la RAM a la VRAM"),
    (0, 0x4803): ("lmmm", "orden LMMM del V9938: copia un rectangulo con operacion logica"),
    (0, 0x484F): ("sube_letras", "sube B letras a la VRAM"),
    (0, 0x4858): ("sube_una_letra", "sube una letra a la VRAM"),
    (0, 0x4879): ("sube_un_dibujo", "sube un dibujo de 8x8 a la VRAM"),
    (0, 0x488E): ("sube_dibujos", "sube B dibujos de 8x8 a la VRAM"),
    (0, 0x48A3): ("sube_dibujos_de_16", "sube dibujos de 16x16 a la VRAM"),
    (0, 0x48B8): ("sube_dibujos_de_16_vueltos", "sube dibujos de 16x16 a la VRAM, vueltos"),
    (0, 0x48CD): ("letra_a_4_bits", "pasa una letra de 1 bit a 4 bits por punto"),
    (0, 0x48F3): ("rotulo", "pinta un rotulo"),
    (0, 0x48F7): ("borra_rotulo", "borra un rotulo"),
    (0, 0x48FD): ("rotulo_sin_posicion", "pinta un rotulo donde se quedo el anterior"),
    (0, 0x491C): ("letra", "pinta una letra"),
    (0, 0x4940): ("caracter", "pinta un caracter"),
    (0, 0x4964): ("caracter_en_la_pagina_1", "pinta un caracter en la pagina 1 de la VRAM"),
    (0, 0x4976): ("sitio_del_caracter", "la direccion en la VRAM de un caracter"),
    (0, 0x4984): ("siguiente_sitio", "pasa al sitio del caracter siguiente"),
    (0, 0x498E): ("prepara_el_vdp", "pasa a SCREEN 5 y pone los registros del V9938"),
    (0, 0x49D2): ("lee_los_mandos", "teclado y mandos: 0xC00C lo apretado, 0xC00B lo nuevo"),
    (0, 0x4A43): ("dibujos_de_konami", "sube los dibujos del logotipo de Konami"),
    (0, 0x4A6D): ("letras_del_texto", "sube las letras de los textos"),
    (0, 0x4A96): ("caracteres_del_juego", "sube los caracteres del juego de graficos de la zona"),
    (0, 0x4B91): ("caracteres_del_titulo", "sube los caracteres del titulo"),
    (0, 0x4C75): ("sube_dibujos_vueltos", "sube dibujos dados la vuelta"),
    (0, 0x4CAB): ("sprites_del_jugador", "sube los sprites del jugador"),
    (0, 0x4CE3): ("paleta_de_la_zona", "pone la paleta del juego de graficos de la zona"),
    (0, 0x4CFC): ("paleta_base", "pone la paleta base"),
    (0, 0x4D2C): ("colores_del_sitio", "cambia los colores del sitio (0xC267)"),
    (0, 0x4D81): ("palabra_de_tabla", "HL = la palabra A de la tabla de HL"),
    (0, 0x4DA4): ("dibujos_de_siempre", "sube los dibujos que estan en todas las zonas"),
    (0, 0x4E7F): ("hmmc_a_la_pagina_1", "HMMC a la pagina 1 de la VRAM"),
    (0, 0x4E84): ("pinta_bloque", "pinta un bloque de 4x4 caracteres"),
    (0, 0x4EB9): ("pinta_icono", "copia un icono del marcador desde la pagina 1 (HMMM)"),
    (0, 0x4F26): ("marca_casilla", "marca una casilla en el plano"),
    (0, 0x4F47): ("pinta_pasadizo", "pinta un pasadizo"),
    (0, 0x4FB5): ("sonido_a_cero", "para la musica y los efectos"),
    (0, 0x4FE4): ("sonido", "arranca la musica o el efecto A"),
    (0, 0x51D6): ("suena_algo", "lo que esta sonando (0xC0A9-0xC0AD)"),
    (0, 0x51ED): ("monta_la_pantalla", "monta la pantalla de 8x6 bloques de la casilla"),
    (0, 0x5306): ("pantalla_de_la_casilla", "A = la pantalla de la casilla de 0xC281 (tabla de 0xE700)"),
    (0, 0x5311): ("rejilla_de_la_zona", "la rejilla de casillas de la zona"),
    (0, 0x534E): ("pinta_la_pantalla", "pinta la pantalla montada"),
    (0, 0x53E3): ("figura_del_interior", "la figura de un interior (tipos 0x22-0x24)"),
    (0, 0x5413): ("dibujos_de_las_figuras", "sube los dibujos de las figuras (fichas de 0xA830, banco 12)"),
    (0, 0x54E6): ("colores_de_la_figura", "pinta los colores de los sprites de la figura"),
    (0, 0x57FA): ("pinta_cosa_del_marcador", "pinta una de las 10 cosas del marcador"),
    (0, 0x5856): ("pinta_las_cosas", "pinta las cosas del marcador"),
    (0, 0x5884): ("suma_vida", "suma vida al jugador"),
    (0, 0x5890): ("pinta_la_vida", "pinta la barra de vida"),
    (0, 0x58F5): ("pinta_el_tiempo", "pinta el tiempo"),
    (0, 0x5915): ("resta_bcd", "resta en BCD"),
    (0, 0x591F): ("suma_bcd", "suma en BCD"),
    (0, 0x5929): ("suma_dinero", "suma ryo al dinero"),
    (0, 0x593A): ("pinta_el_dinero", "pinta el dinero"),
    (0, 0x5958): ("resta_dinero", "resta ryo al dinero"),
    (0, 0x5969): ("ensena_el_plano", "ensena el plano de la zona"),
    (0, 0x59A9): ("dibuja_el_plano", "dibuja el plano de la zona"),
    (0, 0x5A93): ("pantalla_del_titulo", "monta la pantalla del titulo"),
    (0, 0x5B61): ("sube_colores_de_sprite", "sube los colores de los sprites"),
    (0, 0x5B6D): ("figuras_de_la_casilla", "crea las figuras de la casilla"),
    (0, 0x5DBB): ("maquina_de_estados", "despacha por el estado de 0xC000"),
    (0, 0x5E2D): ("cambia_de_estado", "pasa al estado A"),
    (0, 0x5E40): ("espera_y_sigue", "espera y pasa al paso siguiente"),
    (0, 0x5E43): ("siguiente_paso", "pasa al paso siguiente (0xC001)"),
    (0, 0x5EEF): ("siguiente_estado", "pasa al estado siguiente"),
    (1, 0x65F7): ("sale_de_la_casilla", "pasa a la casilla vecina por el lado de salida"),
    (1, 0x663A): ("carga_la_zona", "carga la zona de 0xC280"),
    (1, 0x67B3): ("borra_las_figuras", "borra todas las figuras"),
    (1, 0x67CC): ("borra_al_jugador", "borra al jugador"),
    (1, 0x67DA): ("esconde_los_sprites_de_ram", "saca de la pantalla los sprites de la copia en RAM"),
    (1, 0x6C03): ("teclea_la_contrasena", "la pantalla de la contrasena"),
    (1, 0x6C7A): ("aplica_la_contrasena", "saca de la contrasena la fase, el jugador, la zona y la casilla"),
    (1, 0x6CAB): ("junta_nibbles", "junta dos nibbles en un byte"),
    (1, 0x6CD8): ("lee_el_teclado", "lee una tecla"),
    (1, 0x7804): ("caracter_bajo", "el caracter que hay bajo un punto"),
    (1, 0x781F): ("se_puede_pisar", "carry si el caracter se puede pisar"),
    (1, 0x7EAB): ("busca_al_vecino", "busca el Game Master o Q*bert en otra ranura (0xEF00)"),
    (2, 0x8334): ("crea_figura", "crea una figura en el primer hueco libre de 0xC600"),
    (2, 0x87B7): ("borra_la_figura", "borra la figura"),
    (2, 0x87E4): ("pon_velocidad_x", "velocidad horizontal de la figura ((ix+8), (ix+9)) = DE"),
    (2, 0x87EB): ("pon_velocidad_y", "velocidad vertical de la figura ((ix+6), (ix+7)) = DE"),
    (2, 0x893D): ("pon_la_pose", "pone la pose de la figura"),
    (2, 0x89C2): ("dispara", "crea el disparo A (tabla de 0x8B6B)"),
    (2, 0x8C0A): ("niega_de", "DE = -DE"),
    (2, 0x90C0): ("cosas_fijas", "pinta las cosas fijas de la casilla"),
    (2, 0x960C): ("texto_de_la_zona", "el texto de la zona"),
    (2, 0x99FB): ("dibujo_de_caracteres", "pinta un dibujo hecho de caracteres"),
    (3, 0xBAD2): ("hl_mas_de", "HL += DE"),
    (3, 0xBDF6): ("teclea_palabra", "lo que se teclea en la pausa"),
    (3, 0xBE4E): ("claves_secretas", "compara lo tecleado con las claves secretas (0xBE8A)"),
    (10, 0x6000): ("sonido_del_cuadro", "un cuadro de sonido: musica y efectos"),
    (10, 0x6067): ("canal_en_reposo", "el canal que no suena"),
    (10, 0x608F): ("pon_el_tono", "escribe el tono del canal en el PSG"),
    (10, 0x609B): ("pon_el_volumen", "escribe el volumen del canal en el PSG"),
    (10, 0x61F1): ("lee_la_partitura", "lee la nota siguiente de la partitura"),
    (10, 0x6454): ("cuadro_del_efecto", "un cuadro del efecto de sonido"),
}

# direccion -> (que es, de donde se sabe)
RAM = {
    0xC000: ("el ESTADO del juego", "p00:5DBF despacha por el"),
    0xC001: ("el paso del estado", "p00:5E43 lo sube"),
    0xC002: ("las banderas de la partida (bit 7 jugador 2, bit 6 en juego)", "p00:416F"),
    0xC003: ("el contador de cuadros", "p00:5DBB"),
    0xC004: ("la espera del estado, en cuadros", "p00:5E40"),
    0xC005: ("el semaforo de la interrupcion", "p00:4045"),
    0xC00A: ("el mando de la demostracion", "p00:49D2"),
    0xC00B: ("lo que se acaba de apretar", "p00:49D2"),
    0xC00C: ("lo que esta apretado", "p00:49D2"),
    0xC010: ("el manejador del canal A del sonido", "p10:6000"),
    0xC012: ("el manejador del canal B del sonido", "p10:6000"),
    0xC014: ("el manejador del canal C del sonido", "p10:6000"),
    0xC016: ("el manejador del efecto de sonido", "p10:6000"),
    0xC018: ("el manejador del segundo efecto", "p10:6000"),
    0xC09F: ("la copia del registro 7 del PSG (el mezclador)", "p10"),
    0xC0AB: ("los canales que suenan", "p00:51D6"),
    0xC0AD: ("la musica que suena", "p00:4FE4"),
    0xC257: ("los puntos del jugador 1 (BCD)", "p00:437E"),
    0xC25A: ("los puntos del jugador 2 (BCD)", "p00:437E"),
    0xC260: ("las vidas", "p00:435E las pone a 3"),
    0xC262: ("los puntos de la proxima vida", "p00:43AA"),
    0xC265: ("el DINERO (ryo, BCD)", "p00:5929 y p00:5958"),
    0xC267: ("los colores del sitio", "p00:4D2C; 0 al entrar en la zona"),
    0xC268: ("si ya entro en la zona", "p01:663A"),
    0xC270: ("las 10 cosas del marcador", "p00:57FE"),
    0xC27F: ("si se puede continuar", "p01:6C7A"),
    0xC280: ("la ZONA (0-6)", "p00:41F6"),
    0xC281: ("la CASILLA de la zona", "p00:5306"),
    0xC283: ("el lado por el que se sale (0 arriba, 1 abajo, 2 izquierda, 3 derecha)", "p01:65F7"),
    0xC288: ("la FASE (0-6)", "p00:41F6"),
    0xC289: ("el juego de graficos de la zona", "p00:4A96 y p00:416F"),
    0xC480: ("la vida maxima", "p00:5890"),
    0xC481: ("la VIDA del jugador", "p00:5884 y p00:5890"),
    0xC482: ("la pantalla especial", "p00"),
    0xC483: ("si esta en un pasadizo", "p00:4F47"),
    0xC490: ("el estado del jugador", "p01"),
    0xC494: ("la y del jugador", "p01:7804"),
    0xC496: ("la x del jugador", "p01:7804"),
    0xC498: ("la y de los sprites del jugador", "p00:4CAB"),
    0xC49A: ("la x de los sprites del jugador", "p00:4CAB"),
    0xC49F: ("la accion del jugador", "p01"),
    0xC4A2: ("el lado al que mira el jugador", "p01"),
    0xC4AE: ("el parpadeo del jugador", "p01"),
    0xC4B0: ("el TIEMPO (BCD)", "p00:58F5"),
    0xC580: ("lo tecleado en la pausa", "p03:BDF6"),
    0xCD27: ("la y de la pieza", "p00:4E84"),
    0xCD28: ("la x de la pieza", "p00:4E84"),
    0xCD2A: ("la marca de 0xD800", "p00:51ED"),
    0xCDB1: ("si se esta viendo el plano", "p00:5969"),
    0xEB81: ("la tecla", "p01:6CD8"),
    0xEB83: ("los caracteres de la contrasena", "p01:6C03"),
    0xEF00: ("el VECINO: 0xFF con el Game Master o Q*bert en otra ranura", "p01:7EAB"),
    0xEF80: ("los SECRETOS que ponen las claves", "p03:BE4E"),
    0xF0F1: ("la copia del banco de 0x6000", "se escribe con el registro del mapper"),
    0xF0F2: ("la copia del banco de 0x8000", "se escribe con el registro del mapper"),
    0xF0F3: ("la copia del banco de 0xA000", "se escribe con el registro del mapper"),
}

# Lo que es la PALABRA que empieza en esa direccion, para `ld hl,(nn)`,
# `ld (nn),de`... cuando no es lo mismo que el byte.
RAM16 = {
    0xC000: "el estado (0xC000) y el paso (0xC001) de un tiron",
}

# Los campos de la ficha de cada figura (IX apunta a ella: 0xC600 + 0x80 * n,
# ocho, p02:8334). De donde sale cada uno:
#   0      p02:8334 busca el primer hueco con 0 aqui; p01:7ACA elige por el la caja
#   1      se despacha por el y se sube para pasar al paso siguiente
#   2-3    p02:8791 les suma (ix+6, ix+7); la y es (ix+3) (p03:A008, p01:7AE1)
#   4-5    p02:877D les suma (ix+8, ix+9); la x es (ix+5)
#   0x0A   la pose (p02:8D21, p02:96B4)
#   0x20   cuantos sprites lleva (p02:835C)
CAMPOS = {
    0x00: "el tipo de la figura",
    0x01: "el paso en que va la figura",
    0x02: "la fraccion de la y de la figura",
    0x03: "la y de la figura",
    0x04: "la fraccion de la x de la figura",
    0x05: "la x de la figura",
    0x06: "la velocidad vertical (parte baja)",
    0x07: "la velocidad vertical",
    0x08: "la velocidad horizontal (parte baja)",
    0x09: "la velocidad horizontal",
    0x0A: "la pose de la figura",
    0x20: "cuantos sprites lleva la figura",
}

REGISTROS_MAPPER = {0x6000: "0x6000", 0x8000: "0x8000", 0xA000: "0xA000"}


def listado(b):
    filas = []
    for ln in open(os.path.join(RAIZ, "src", "goemon_p%02d.asm" % b), encoding="utf-8"):
        m = re.match(r"\t([a-z][^\t;]*?)\s*;([0-9a-f]{4})", ln)
        if m and not ln.startswith("\tdefb"):
            filas.append((int(m.group(2), 16), m.group(1).strip()))
    return filas


def a_mano(b):
    """Direcciones con C escrita fuera de la seccion, y los L ya puestos."""
    ruta = os.path.join(RAIZ, "src", "p%02d.notes" % b)
    cs, ls, dentro = set(), set(), False
    for ln in open(ruta, encoding="utf-8"):
        if ln.startswith(INI):
            dentro = True
        elif ln.startswith(FIN):
            dentro = False
        elif not dentro and ln.startswith("C "):
            cs.add(int(ln.split()[1], 0))
        elif not dentro and ln.startswith("L "):
            ls.add(int(ln.split()[1], 0))
    return cs, ls


def num(txt):
    txt = txt.strip()
    return int(txt[:-1], 16) if txt.endswith("h") else int(txt, 0)


def valor(txt):
    txt = txt.strip()
    return int(txt[:-1], 16) if txt.endswith("h") else int(txt, 0)


def por_nombre():
    """nombre de etiqueta del listado -> (banco, direccion)."""
    return {}


# En el banco 0 IX solo se carga con `push hl / pop ix` en p00:546A, y es la
# ficha de 0xA830 del banco 12, no una figura: el banco entero queda fuera.
NO_FICHAS = {
    0: [(0x4000, 0x6000)],
}


def fichas_de(filas):
    """Para cada instruccion, si IX apunta ahi a una figura.

    Hay tres listas con los mismos campos 0-0x0A y 0x20: 0xC600 (ocho de
    0x80, p02:8334), 0xCA00 (de 0x40, p02:86F1 y p02:88B0) y 0xCC00 (cuatro de
    0x40, p02:8CB0); las tres pasan por p02:877A (posicion) y p02:87F2 (pose).
    Se da por buena salvo en un tramo (hasta un `ret` o un `jp`) en el que IX
    se carga con otra direccion.
    """
    fuera, malo = {}, False
    for k, (a, t) in enumerate(filas):
        m = re.match(r"ld ix,0([0-9a-f]{4})h$", t)
        if m:
            v = int(m.group(1), 16)
            malo = not (0xC600 <= v < 0xCD00)
        fuera[k] = not malo
        if t.startswith(("ret", "jp ")) and not re.match(r"ret [a-z]", t):
            malo = False
    return fuera


def comentario(b, filas, k, fichas):
    a, t = filas[k]
    # llamadas y saltos a rutinas con nombre
    m = re.match(r"(call|jp)\s+(?:(?:nz|z|nc|c|po|pe|p|m),)?(?:L_([0-9A-F]{4})|0([0-9a-f]{4})h|([a-z_][a-z0-9_]*))$", t)
    if m and m.group(4):
        # ya lleva el nombre puesto: basta con decir que hace
        for (bb, aa), (nom, que) in RUTINAS.items():
            if nom == m.group(4):
                return "%s: %s" % (nom, que)
        m = None
    if m:
        dest = int(m.group(2) or m.group(3), 16)
        for (bb, aa), (nom, que) in RUTINAS.items():
            if bb == 10 and b != bb:
                continue            # el sonido solo esta en 0x6000 cuando lo llama la interrupcion
            if aa == dest and (bb == b or ORG[bb] == 0x4000 or not (ORG[b] <= dest < ORG[b] + 0x2000)):
                if bb == 0 or ORG[bb] <= dest < ORG[bb] + 0x2000:
                    return "%s: %s" % (nom, que)
    # los campos de la figura
    if b in (0, 1, 2, 3) and fichas.get(k, False) and \
            not any(i <= a < f for i, f in NO_FICHAS.get(b, [])):
        mm = re.search(r"\(ix\+0?([0-9a-f]+)h?\)", t)
        if mm:
            n = int(mm.group(1), 16)
            que = CAMPOS.get(n)
            if que:
                op = t.split()[0]
                if op == "ld" and t.startswith("ld (ix"):
                    v = t.split(",", 1)[1]
                    if re.match(r"^[a-z]$", v):
                        return "guarda %s" % que
                    v = "0x%02X" % num(v) if re.match(r"^[0-9a-f]+h$", v) else v
                    return "%s = %s" % (que, v)
                if op == "ld":
                    return "lee %s" % que
                if op in ("inc", "dec"):
                    return ("sube " if op == "inc" else "baja ") + que
                if op == "bit":
                    return "mira el bit %s de %s" % (t.split()[1].split(",")[0], que)
                if op in ("set", "res"):
                    return "%s el bit %s de %s" % ("pone a uno" if op == "set" else "pone a cero",
                                                   t.split()[1].split(",")[0], que)
                if op in ("cp", "sub", "add", "adc", "sbc", "and", "or", "xor"):
                    return {"cp": "compara con ", "sub": "le resta ", "add": "le suma ",
                            "adc": "le suma ", "sbc": "le resta ", "and": "AND con ", "or": "OR con ",
                            "xor": "XOR con "}[op] + que
    # cambios de banco
    m = re.match(r"ld \(0(6000|8000|a000)h\),a$", t)
    if m:
        reg = int(m.group(1), 16)
        return "el mapper: pone en %s el banco de A" % REGISTROS_MAPPER[reg]
    # RAM
    m16 = re.match(r"ld (?:(hl|de|bc|ix|iy),\(0([c-f][0-9a-f]{3})h\)|\(0([c-f][0-9a-f]{3})h\),(hl|de|bc|ix|iy))$", t)
    if m16:
        v = int(m16.group(2) or m16.group(3), 16)
        if v in RAM16:
            return ("lee " if m16.group(1) else "guarda ") + RAM16[v]
    for x in re.findall(r"\b0([c-f][0-9a-f]{3})h\b", t):
        v = int(x, 16)
        if v in RAM:
            que = RAM[v][0]
            if re.match(r"ld \(0%04xh\)," % v, t):
                return "guarda %s" % que
            if re.match(r"ld [a-z]+,\(0%04xh\)$" % v, t):
                return "lee %s" % que
            if re.match(r"ld (hl|de|bc|ix|iy),0%04xh$" % v, t):
                return "apunta a %s" % que
            return que
    return None


def main(argv):
    total = 0
    for b in BANCOS:
        filas = listado(b)
        cs, ls = a_mano(b)
        fichas = fichas_de(filas)
        lineas = []
        for (bb, aa), (nom, que) in sorted(RUTINAS.items()):
            if bb == b and aa not in ls:
                lineas.append("L 0x%04X %s %s" % (aa, nom, que))
        n = 0
        for k, (a, t) in enumerate(filas):
            if a in cs:
                continue
            c = comentario(b, filas, k, fichas)
            if c:
                lineas.append("C 0x%04X %s" % (a, c))
                n += 1
        total += n
        print("p%02d: %d comentarios, %d nombres" % (b, n, sum(1 for l in lineas if l.startswith("L "))))
        if "--escribe" in argv:
            ruta = os.path.join(RAIZ, "src", "p%02d.notes" % b)
            viejas = open(ruta, encoding="utf-8").read().split("\n")
            nuevas, dentro = [], False
            for ln in viejas:
                if ln.startswith(INI):
                    dentro = True
                    continue
                if ln.startswith(FIN):
                    dentro = False
                    continue
                if not dentro:
                    nuevas.append(ln)
            while nuevas and not nuevas[-1].strip():
                nuevas.pop()
            nuevas += ["", INI] + lineas + [FIN, ""]
            open(ruta, "w", encoding="utf-8", newline="\n").write("\n".join(nuevas))
    print("en total: %d comentarios" % total)


if __name__ == "__main__":
    main(sys.argv)
