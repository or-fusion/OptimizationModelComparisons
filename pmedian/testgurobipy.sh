#!/bin/sh

time (python pmedian_gurobipy.py  160 1 )
time (python pmedian_gurobipy.py  320 1 )
time (python pmedian_gurobipy.py  640 1 )
time (python pmedian_gurobipy.py 1280 1 )
