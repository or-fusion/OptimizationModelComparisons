#!/bin/sh

# NOTE: Writing an LP file is a lower bound on the runtime
#       of Poek with GURBOI.

echo "25"
python poek_gurobi25.py  | ts -s "%.s"
echo "50"
python poek_gurobi50.py  | ts -s "%.s"
echo "75"
python poek_gurobi75.py  | ts -s "%.s"
echo "100"
python poek_gurobi100.py | ts -s "%.s"
