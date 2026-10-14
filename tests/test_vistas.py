"""La vista en primera persona de los pasadizos secretos (tools/vistas.py):
lo que la pagina EL JUEGO / THE GAME afirma, medido otra vez sobre la ROM.
"""
import os
import sys
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))

import graficos as G             # noqa: E402
import vistas as V               # noqa: E402


class Vistas(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.cart = G.Cartucho()
        cls.zonas = sorted(V.P.zonas_con_pasadizo(cls.cart))

    def test_el_cartucho_ve_lo_mismo(self):
        """p03:B936 ejecutado con z80run en dos pasadizos: cada casilla y
        direccion igual que lo_que_se_ve (todos: vistas.py coteja)."""
        self.assertEqual(V.coteja_z80([0, 34]), 0)

    def test_cada_recorrido_sale_y_lo_coge_todo(self):
        for z in self.zonas:
            acciones, estados = V.recorrido(self.cart, z)
            (x, y, d), rejilla = estados[-1]
            self.assertIsNone(V.mueve([f[:] for f in rejilla], x, y, d, acciones[-1]), z)
            self.assertFalse(any(c in (2, 3, 4, 5) for fila in rejilla for c in fila), z)
            self.assertEqual(len(acciones), len(estados), z)

    def test_las_33_piezas(self):
        vistas = set()
        for z in self.zonas:
            for (x, y, d), rejilla in V.recorrido(self.cart, z)[1]:
                vistas |= set(V.dibujos(V.lo_que_se_ve(rejilla, x, y, d)))
        self.assertEqual(vistas, set(range(0x21)))
        self.assertEqual(sorted(n for fila in V.FILAS_DE_PIEZAS for n in fila), list(range(0x21)))

    def test_la_pagina_enlaza_los_42(self):
        for ruta, img in (("docs/THE-GAME.md", "imagenes/"), ("docs/es/EL-JUEGO.md", "../imagenes/")):
            texto = open(os.path.join(RAIZ, ruta), encoding="utf-8").read()
            for z in self.zonas:
                nombre = "vista_%d_%d.gif" % (z // 7 + 1, z % 7)
                self.assertIn("%s%s" % (img, nombre), texto)
                self.assertTrue(os.path.exists(os.path.join(RAIZ, "docs", "imagenes", nombre)), nombre)


if __name__ == "__main__":
    unittest.main()
