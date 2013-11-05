# -*- coding: utf-8 -*-
# author: Flavio Regis de Arruda
# creation date: 15/10/2012

import numpy as np
cimport numpy as np
cimport cython
from cython.parallel import prange
from libc.math cimport log

DTYPE = np.float64

ctypedef np.float64_t DTYPE_T


cdef double avg(double x1, double x2) nogil :
    cdef double y
    y = (x1 + x2)/2.0
    return y

@cython.cdivision(True)
cdef double kl(double x1, double x2) nogil :
    cdef double y
    y = 0.5 * x1 * log(x1/x2)
    return y

cdef double sum(double x1, double x2) nogil:
   cdef double y
   y = x1 + x2
   return y

@cython.boundscheck(False) # turn of bounds-checking for entire function
@cython.wraparound(False)
@cython.nonecheck(False)
def js_div(np.ndarray[DTYPE_T, ndim=1] hist1, np.ndarray[DTYPE_T, ndim=1] hist2):
    cdef int i, dim
    cdef double hf, h1, h2, kl1, kl2, result
    dim = hist1.shape[0]
    result = 0.0
    for i in prange(dim, nogil=True):
        h1 = hist1[i]
        h2 = hist2[i]
        hf = avg(h1,h2)
        kl1 = kl(h1,hf)
        kl2 = kl(h2,hf)
        result += sum(kl1, kl2)

    return result

