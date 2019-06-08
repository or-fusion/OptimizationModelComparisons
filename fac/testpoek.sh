#!/bin/sh

# NOTE: Writing an LP file is a lower bound on the runtime
#       of Poek with GURBOI.

python poek25.py | ts -s
python poek50.py | ts -s
python poek75.py | ts -s
python poek100.py | ts -s
