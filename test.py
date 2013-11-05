#! /usr/bin/env python

import sys
import numpy as np
import js

sys.stdout.write("Testing js_div :  ")

a = np.array([5,4,3,2,1],dtype=np.float64)
b = np.array([4,5,2,3,1],dtype=np.float64)

# L1 normalize.
a = a/a.sum() 
b = b/b.sum()

js_div = js.js_div(a,b)

assert abs(js_div - 0.01042) < 0.001, "Error: expected 0.01042 but got: %.4f" % js_div

print "OK."
