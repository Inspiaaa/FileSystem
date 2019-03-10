from distutils.core import setup
from Cython.Build import cythonize
import numpy


setup(
    script_name='setup.py',
    script_args=['build_ext', '--inplace'],
    ext_modules=cythonize("Lib\\*.pyx", compiler_directives={
        "embedsignature": True,

        "language_level": "-3"})
)
