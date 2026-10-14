"""Los textos (tools/textos.py): lo que la pagina LOS-TEXTOS / THE-TEXTS
afirma, medido otra vez sobre la ROM y el listado.
"""
import os
import re
import sys
import tempfile
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))

import graficos as G             # noqa: E402
import textos as X               # noqa: E402
import textos_traduccion as T    # noqa: E402

LLAMADAS = (0xCD, 0xC3, 0xC4, 0xCC, 0xD4, 0xDC, 0xC2, 0xCA, 0xD2, 0xDA, 0xE4, 0xEC, 0xF4, 0xFC, 0xE2, 0xEA, 0xF2, 0xFA)


class Textos(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.cart = G.Cartucho()
        cls.rom = open(os.path.join(RAIZ, "goemon.rom"), "rb").read()
        cls.todos = X.todos(cls.cart)

    def _en_los_bytes(self, destino):
        lo, hi = destino & 0xFF, destino >> 8
        return sum(len(re.findall(re.escape(bytes((op, lo, hi))), self.rom)) for op in LLAMADAS)

    def test_las_llamadas_de_los_bytes_son_las_del_listado(self):
        sitios = X.sitios_que_piden()
        a_4280 = [s for s in sitios if s[1] in ("04280h", "rotulo_numero")]
        self.assertEqual(len(a_4280), self._en_los_bytes(0x4280))
        self.assertEqual(len(sitios) - len(a_4280), self._en_los_bytes(0xB836))

    def test_solo_dos_rotulos_sin_quien_los_pida(self):
        piden = X.pedidos(self.cart)
        self.assertEqual([n for n in range(X.N_ROTULOS) if n not in piden], [0x10, 0x17])
        self.assertEqual(max(piden), X.N_ROTULOS - 1)

    def test_los_seis_ultimos_punteros_van_al_final(self):
        for n in range(X.N_ROTULOS, 120):
            self.assertEqual(self.cart.palabra(X.TABLA_ROTULOS + 2 * n, G.S10), X.FIN_ROTULOS)

    def test_0x10_y_0x11_comparten_texto(self):
        p = [self.cart.palabra(X.TABLA_ROTULOS + 2 * n, G.S10) for n in (0x10, 0x11)]
        self.assertEqual(p[0], p[1])

    def test_todas_las_letras_se_leen(self):
        for e in self.todos:
            if e.get("trozos") and X.es_dibujo(e["trozos"]):
                continue
            for l in e["lineas"]:
                self.assertNotIn("[", l, e["clave"])

    def test_todo_tiene_traduccion(self):
        claves = [e["clave"] for e in self.todos]
        self.assertEqual(len(claves), len(set(claves)))
        self.assertEqual(set(claves), set(T.TRAD))

    def test_cuantos(self):
        grupos = {}
        for e in self.todos:
            grupos[e["grupo"]] = grupos.get(e["grupo"], 0) + 1
        self.assertEqual(grupos, {"menu": 14, "rotulo": 115, "zona": 35, "fase": 8, "final": 7, "clave": 6})

    def test_los_cuatro_finales(self):
        self.assertEqual(X.finales(self.cart), [[1, 3], [0, 2, 4, 5], [1, 3, 6], [0, 2, 4, 6]])

    def test_la_pagina_lleva_todo(self):
        docs = tempfile.mkdtemp()
        os.makedirs(os.path.join(docs, "es"))
        import textos_pagina
        for ruta in textos_pagina.pagina(docs):
            texto = open(ruta, encoding="utf-8").read()
            for e in self.todos:
                self.assertIn("`%s`" % e["sitio"], texto, e["clave"])


if __name__ == "__main__":
    unittest.main()
