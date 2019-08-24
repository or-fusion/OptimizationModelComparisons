#!/bin/sh

# NOTE: Writing an LP file is a lower bound on the runtime
#       of Poek with GURBOI.

time (python poek.py  500 )
time (python poek.py 1000 )
time (python poek.py 1500 )
time (python poek.py 2000 )
