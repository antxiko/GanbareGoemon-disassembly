"""El plano de la provincia (tools/mapa_fase.py) y la sala del senor
(tools/sala.py): lo que dice EL JUEGO / THE GAME, medido otra vez sobre la
ROM. El cotejo con openMSX necesita las grabaciones de work/ (no van en el
repositorio): `mapa_fase.py coteja` y `sala.py coteja`.
"""
import os
import sys
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))

import graficos as G             # noqa: E402
import mapa_fase as M            # noqa: E402
import sala as S                 # noqa: E402


class Plano(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.cart = G.Cartucho()

    def test_la_provincia_tres_kanji_y_dos_en_la_ultima(self):
        for fase in range(7):
            lista, colores = M.sprites_de_la_fase(self.cart, fase)
            self.assertEqual(len(lista) - 2, 2 if fase == 6 else 3, fase)   # 0x818F: 1C FF 30, el FF salta
            self.assertEqual(len(colores), len(lista))

    def test_la_marca_de_goemon(self):
        lista, colores = M.sprites_de_la_fase(self.cart, 0, zona=3)
        y, x = self.cart.leer(M.PUNTOS + 6, G.S1), self.cart.leer(M.PUNTOS + 7, G.S1)
        self.assertEqual(lista[:2], [(y, x, 0x3C), (y, x, 0x38)])
        self.assertEqual(colores[1][0], 0x41)        # el segundo con CC


class Sala(unittest.TestCase):
    def test_el_texto_de_cada_fase(self):
        cart = G.Cartucho()
        mem = bytearray(0x10000)
        for fase in range(7):
            mem[0xC288], mem[0xCD60] = fase, 0
            self.assertEqual(S.texto_de_la_fase(cart, mem), cart.palabra(0x9E0B + 2 * fase, G.S1))
            mem[0xCD60] = 8
            esperado = cart.palabra(0x9E0B + 12, G.S1) if fase == 6 else 0x9F92
            self.assertEqual(S.texto_de_la_fase(cart, mem), esperado, fase)


class Pagina(unittest.TestCase):
    def test_los_gif_enlazados_y_en_su_sitio(self):
        nombres = ["plano_fase_%d.gif" % k for k in range(1, 8)] + ["sala_fase_%d.gif" % k for k in range(1, 8)]
        nombres.append("sala_enfadado.gif")
        for ruta, img in (("docs/THE-GAME.md", "imagenes/"), ("docs/es/EL-JUEGO.md", "../imagenes/")):
            texto = open(os.path.join(RAIZ, ruta), encoding="utf-8").read()
            for n in nombres:
                self.assertIn(img + n, texto, (ruta, n))
                self.assertTrue(os.path.exists(os.path.join(RAIZ, "docs", "imagenes", n)), n)


if __name__ == "__main__":
    unittest.main()
