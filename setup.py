# -*- coding: utf-8 -*-
# author: Flavio Regis de Arruda
# creation date: 15/10/2012

from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext

setup(
    cmdclass = {'build_ext': build_ext},
    ext_modules = [Extension("js", ["JS.pyx"])]
)
