#!/usr/bin/env python3
"""La sala del senor: el final de cada fase (el estado 0x0B, pasos 2 y 3),
cuadro a cuadro, ejecutando el codigo del cartucho con tools/z80run.py.

EL CUADRO. Todo el juego corre desde la interrupcion (p00:4045): el sonido
del cuadro (call 0x6000 con los bancos 10, 11 y 12) y luego
maquina_de_estados (p00:5DBB), con los bancos de las copias de 0xF0F1-0xF0F3.
Aqui un cuadro es eso mismo. La BIOS que se cruza se atrapa (WRTVDP no hace
nada; WRTPSG y RDPSG, el PSG de z80run).

LA ESCENA. El paso 2 (p01:6120) monta la sala y p02:9A46 prepara las
figuras; el paso 3 (p01:6145) mueve cada cuadro las figuras y los pasos de
p02:9B34 (tabla 0x9B3A): esperas de 32, 64, 192 y 160 cuadros, la figura
0x1D, el rotulo 0x0D, la caja (HMMV del 0x22) y el texto de la fase, una
letra cada 7 cuadros. Acaba cuando 0xCD11 = 0 y no suena nada.

DE DONDE SALE. La RAM con la que empieza la escena (0xC000-0xFFFF, el paso 3
recien empezado) es un volcado de openMSX (tools/omsx_sala.tcl,
work/v_sala/v0000.ram): de ahi en adelante cada cuadro lo calcula el
cartucho. Lo dibujado es nuestro: la sala de los caracteres de 0xD800 como
p00:534E, encima la caja y las letras, y los sprites de la copia de 0xEE00.

Uso:  sala.py          docs/imagenes/sala_fase_1..7.gif y sala_enfadado.gif (0xCD60 = 8)
      sala.py coteja   contra la grabacion de work/v_sala (tools/omsx_sala.tcl)
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import graficos as G  # noqa: E402
from motor_musica import Cartucho as Z80Rom, WRTPSG, RDPSG, GICINI  # noqa: E402
from z80run import ParadaZ80  # noqa: E402

VOLCADO = os.path.join(G.RAIZ, "work", "v_sala")
WRTVDP, SNSMAT = 0x0047, 0x0141


class Juego(Z80Rom):
    """El cartucho en z80run con la BIOS que la escena toca. Los `ld a,r`
    (el registro R, numeros al azar que dependen de los ciclos exactos) dan los
    valores de la partida grabada (azar.txt de tools/omsx_sala.tcl), en orden."""
    azar = []

    def corre(self, desde, tope=3_000_000):
        centinela = 0xFFFE
        self.sp = (self.sp - 2) & 0xFFFF
        self._escribir16(self.sp, centinela)
        self.pc = desde
        self.pasos = 0
        while self.pc != centinela:
            if self.pc < 0x4000 and self.pc != 0:
                if self.pc == WRTPSG:
                    self.maq.psg[self.a & 0x0F] = self.e
                elif self.pc == RDPSG:
                    self.a = self.maq.psg[self.a & 0x0F]
                elif self.pc in (GICINI, WRTVDP):
                    pass
                elif self.pc == SNSMAT:
                    self.a = 0xFF
                else:
                    raise ParadaZ80("llamada a la BIOS 0x%04X" % self.pc)
                self.pc = self._pop()
                continue
            self.pasos += 1
            if self.pasos > tope:
                raise ParadaZ80("mas de %d instrucciones" % tope)
            if self.mem[self.pc] == 0xED and self.mem[(self.pc + 1) & 0xFFFF] == 0x5F:
                if not self.azar or self.azar[0][0] != self.pc:
                    raise ParadaZ80("ld a,r en 0x%04X sin valor grabado (quedan %s)" % (self.pc, self.azar[:1]))
                self.a = self.azar.pop(0)[1]
                self.f = (self.f & 0x01) | (self.a & 0x80) | (0x40 if self.a == 0 else 0)
                self.pc = (self.pc + 2) & 0xFFFF
                continue
            self._una()

    def cuadro(self):
        """p00:4045 sin el vecino: el sonido y un cuadro del juego."""
        for v, b in ((0x6000, 10), (0x8000, 11), (0xA000, 12)):
            self.pon_banco(v, b)
        self.corre(0x6000)
        for v, a in ((0x6000, 0xF0F1), (0x8000, 0xF0F2), (0xA000, 0xF0F3)):
            self.pon_banco(v, self.mem[a])
        self.corre(0x5DBB)


def arranca(fase=None, ram=os.path.join(VOLCADO, "v0000.ram"), golpes=None):
    cart = G.Cartucho()
    z = Juego(dict(mapper="konami", org=0x4000), cart.rom)
    with open(ram, "rb") as f:
        z.mem[0xC000:0x10000] = f.read()
    z.mem[0x0006] = z.mem[0x0007] = 0x98   # VDP.DR y VDP.DW de la BIOS: p00:467F saca de ahi los puertos
    if fase is not None:
        z.mem[0xC288] = fase
    if golpes is not None:              # 0xCD60: con 8 o mas, el senor enfadado (p02:9C3D)
        z.mem[0xCD60] = golpes
    with open(os.path.join(os.path.dirname(ram), "azar.txt")) as f:   # solo los del paso 3
        z.azar = [(int(a, 16), int(v, 16)) for _c, a, v in (l.split() for l in f if l.strip())]
    z.sp = 0xF0F0
    return z


import titulo as T  # noqa: E402

S4, S7, S13 = G.S4, G.S7, G.S13


def vuelto(cart, bancos, rle, dest, v):
    """p00:4562 (como enemigos.vuelto, con los bancos que toquen): el rle con
    cada byte al reves y las dos columnas de cada sprite de 16x16 cambiadas."""
    datos = []
    G.rle(cart, bancos, rle, lambda nuevo, b: datos.append(b) if nuevo is None else None)
    out = bytearray(len(datos) + 32)
    pos, cuenta = 0x10, 0
    for b in datos:
        out[pos] = int("{:08b}".format(b)[::-1], 2)
        pos += 1
        cuenta += 1
        if cuenta % 32 == 0:
            pos += 0x20
        elif cuenta % 32 == 0x10:
            pos -= 0x20
    for i in range(len(datos)):
        v.v[dest + i] = out[i]


def vram_de_la_sala(cart, mem):
    """La pagina 1 y la 0 al empezar el paso 3: las letras (p00:4A6D) y lo de
    siempre (p00:4DA4, los trozos de y 0xC0); p00:4BC5 (46 dibujos de 0x858C,
    31 vueltos de 0x86EC, los sprites de 0x9810 -0x9DF6 con el jugador 2-,
    0x9FB0, su espejo y 0xA10E); la paleta de p00:4D72; la sala de los
    caracteres de 0xD800 (p00:534E, 26 filas desde y 0) y los tres trozos de p02:9A82 con TIMP."""
    v = G.Vram()
    G.letras(G.de_la_rom(cart, S13, 0x929D, 0x91 * 8), 0x00, 0x40, 0x91, 0x0E, v)
    G.letras(G.de_la_rom(cart, S13, 0x9725, 10 * 8), 0x88, 0x60, 10, 0x03, v)
    G.sube_dibujos(G.de_la_rom(cart, S13, 0x9775, 3 * 32), 0xB06C, 3, v)
    G.carga_de_siempre(cart, v)
    G.sube_dibujos(G.de_la_rom(cart, S7, 0x858C, 0x2E * 32), 0x8004, 0x2E, v)
    G.sube_dibujos_vueltos(G.de_la_rom(cart, S7, 0x86EC, 0x1F * 32), 0x842C, 0x1F, v)
    G.rle_a_la_vram(cart, S7, 0xF800, 0x9DF6 if mem[0xC002] & 0x80 else 0x9810, v)
    G.rle_a_la_vram(cart, S7, 0xF880, 0x9FB0, v)
    vuelto(cart, S7, 0x9FB0, 0xFA00, v)
    G.rle_a_la_vram(cart, S7, 0xFB80, 0xA10E, v)
    G.pon_paleta(cart, S7, 0xA3E6, v)
    G.pon_paleta(cart, S7, 0xA48F, v)
    celdas = [[mem[0xD800 + 32 * f + c] for c in range(32)] for f in range(26)]
    G.pinta(v, celdas, 26, 0)          # p00:5357: en el estado 0x0B, desde y 0 y 26 filas
    for (sx, sy), (dx, dy), (an, al) in (((0x00, 0xC0), (0x60, 0x70), (0x0C, 0x10)),
                                         ((0x10, 0xC0), (0x90, 0x70), (0x08, 0x10)),
                                         ((0x18, 0xC0), (0x70, 0x70), (0x20, 0x10))):
        G.lmmm_timp(v, sx, sy, dx, dy, an, al, 1, 0)
    return v


def texto_hasta(cart, v, mem, inicio):
    """p00:42F1 hasta donde va el texto (0xCD65), desde (0x30, 0x30): 0xFE
    baja 8 desde el principio del renglon, 0xE1-0xFD avanza, 0x62 y 0x63
    avanzan 4 y las demas letras 8 (p00:430A)."""
    x0, x, y, a = 0x30, 0x30, 0x30, inicio
    fin = mem[0xCD65] | mem[0xCD66] << 8
    while a < fin:
        c = cart.leer(a, G.S1)
        a += 1
        if c == 0xFF or c == 0xE0:
            break
        if c == 0xFE:
            y += 8
            x = x0
        elif c > 0xE0:
            x = (x + (c - 0xE0) * 8) & 0xFF
        else:
            T.letra(v, c, x, y)
            x = (x + (4 if c in (0x62, 0x63) else 8)) & 0xFF


def caja(cart, v):
    """p02:9B81: el rotulo 0x0D y la caja de (0x30, 0x30), 0xA0 x 0x18, del 0x22."""
    T.rotulo(cart, G.S10, cart.palabra(0xA9C0 + 2 * 0x0D, G.S10), v)
    T.hmmv(v, 0x30, 0x30, 0xA0, 0x18, 0x22, 0)


def texto_de_la_fase(cart, mem):
    """p02:9BBF: 0x9E0B + 2 * fase, o 0x9F92 con 0xCD60 >= 8 (salvo la fase 6)."""
    fase = mem[0xC288]
    if fase != 6 and mem[0xCD60] >= 8:
        return 0x9F92
    return cart.palabra(0x9E0B + 2 * fase, G.S1)


def pagina_0(cart, base, mem):
    """La pagina 0 de este cuadro: la sala y, desde el paso 4 de p02:9B34, la
    caja y el texto hasta donde vaya."""
    v = G.Vram()
    v.v[:] = base.v
    v.paleta = list(base.paleta)
    if mem[0xCD54] >= 4:
        caja(cart, v)
        texto_hasta(cart, v, mem, texto_de_la_fase(cart, mem))
    return v


def imagen(v, mem):
    lista = [tuple(mem[0xEE00 + 4 * i:0xEE03 + 4 * i]) for i in range(32)]
    colores = [list(mem[0xEC00 + 16 * i:0xEC10 + 16 * i]) for i in range(32)]
    return T.imagen(v, 0, T.sprites(v, lista, colores))


def sprites_de(mem):
    return bytes(mem[0xEC00:0xEE80])


class Mirado(Juego):
    """Juego que apunta lo que se escribe en la copia de los sprites."""
    escritos = None

    def _escribir(self, d, v):
        if self.escritos is not None and 0xEC00 <= (d & 0xFFFF) < 0xEE80:
            self.escritos.setdefault(d & 0xFFFF, set()).add(v & 0xFF)
        Juego._escribir(self, d, v)


def coteja(volcado=VOLCADO):
    """Cada linea de sala.txt ([C003] [CD54-CD57] y la copia 0xEC00-0xEE7F) y
    cada volcado vNNNN.vram (la pagina 0) contra lo de z80run. openMSX a toda
    velocidad graba a mitad de cuadro y se salta cuadros: entre linea y linea
    se corren los cuadros que haya avanzado 0xC003, y cada byte de la foto
    tiene que ser el de ese cuadro, el del anterior o uno que el cartucho
    escribio por el camino en ese cuadro."""
    cart = G.Cartucho()
    lineas = [l.split() for l in open(os.path.join(volcado, "sala.txt")).read().splitlines() if l.strip()]
    base_z = arranca(ram=os.path.join(volcado, "v0000.ram"))
    z = Mirado(dict(mapper="konami", org=0x4000), cart.rom)
    z.mem[:] = base_z.mem
    z.azar, z.sp = base_z.azar, base_z.sp
    base = vram_de_la_sala(cart, z.mem)
    hist = [sprites_de(z.mem)]
    pags = [pagina_0(cart, base, z.mem)]
    cuenta = {"igual": 0, "anterior": 0, "a mitad": 0, "distinta": 0}
    malos_p = []
    for k in range(1, len(lineas)):
        z.escritos = {}
        for _ in range((int(lineas[k][0], 16) - int(lineas[k - 1][0], 16)) & 0xFF):
            z.cuadro()
            hist.append(sprites_de(z.mem))
            pags.append(pagina_0(cart, base, z.mem))
        suyo, a, b = bytes.fromhex(lineas[k][5]), hist[-1], hist[-2]
        if suyo == a:
            cuenta["igual"] += 1
        elif suyo == b:
            cuenta["anterior"] += 1
        elif all(suyo[j] in (a[j], b[j]) or suyo[j] in z.escritos.get(0xEC00 + j, ()) for j in range(len(suyo))):
            cuenta["a mitad"] += 1
        else:
            cuenta["distinta"] += 1
        ruta = os.path.join(volcado, "v%04d.vram" % k)
        if os.path.exists(ruta):
            d = open(ruta, "rb").read()
            suya = [(d[y * 128 + x // 2] >> (4 * (1 - x % 2))) & 15 for y in range(212) for x in range(256)]
            if not any(suya == [p.punto(0, x, y) for y in range(212) for x in range(256)] for p in pags[-2:]):
                malos_p.append(k)
        pags = pags[-2:]
    print("sprites, %d lineas: %s" % (len(lineas) - 1, cuenta))
    n = len([f for f in os.listdir(volcado) if f.endswith(".vram")]) - 1
    print("pagina 0, %d volcados: %d distintos %s" % (n, len(malos_p), malos_p[:5]))
    return cuenta["distinta"] + len(malos_p)


def gif(fase, ruta, escala=2, final=2000, golpes=None):
    """La escena de la fase, de la RAM de partida hasta el paso 4 (p01:6168):
    un cuadro del juego cada 1/60 s, juntando los iguales seguidos; las
    duraciones, redondeadas a centesimas sobre el tiempo acumulado. Al final,
    `final` ms con el ultimo cuadro."""
    from PIL import Image
    cart = G.Cartucho()
    z = arranca(fase, golpes=golpes)
    base = vram_de_la_sala(cart, z.mem)
    cuadros, cuentas, ultimo, clave = [], [], None, None
    n = 0
    while True:
        k = (sprites_de(z.mem), z.mem[0xCD54] >= 4, bytes(z.mem[0xCD65:0xCD67]))
        if k != clave:
            img = imagen(pagina_0(cart, base, z.mem), z.mem)
            im = Image.new("RGB", (256, 212))
            im.putdata([px for fila in img for px in fila])
            cuadros.append(im.resize((256 * escala, 212 * escala), Image.NEAREST))
            cuentas.append(0)
            clave = k
        cuentas[-1] += 1
        if z.mem[0xC000] != 0x0B or z.mem[0xC001] >= 4:
            break
        z.cuadro()
        n += 1
    t, dur = 0, []
    for c in cuentas:
        dur.append((round((t + c) * 100 / 60) - round(t * 100 / 60)) * 10)
        t += c
    dur[-1] += final
    dur = [max(d, 20) for d in dur]
    cuadros[0].save(ruta, save_all=True, append_images=cuadros[1:], duration=dur, loop=0, optimize=True)
    return n, len(cuadros)


def main():
    if sys.argv[1:2] == ["coteja"]:
        malos = coteja()
        enfadado = os.path.join(G.RAIZ, "work", "v_sala_enfadado")
        if os.path.isdir(enfadado):
            malos += coteja(enfadado)
        return 1 if malos else 0
    for fase in range(7):
        ruta = os.path.join(G.IMAGENES, "sala_fase_%d.gif" % (fase + 1))
        n, c = gif(fase, ruta)
        print("%s: %d cuadros del juego, %d distintos" % (ruta, n, c))
    ruta = os.path.join(G.IMAGENES, "sala_enfadado.gif")
    n, c = gif(0, ruta, golpes=8)
    print("%s: %d cuadros del juego, %d distintos" % (ruta, n, c))
    return 0


if __name__ == "__main__":
    sys.exit(main())
