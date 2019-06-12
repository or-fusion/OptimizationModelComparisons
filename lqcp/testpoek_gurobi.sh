#!/bin/sh

# NOTE: Writing an LP file is a lower bound on the runtime
#       of Poek with GURBOI.

echo "500"
python poek_gurobi500.py   | ts -s "%.s"
echo "1000"
python poek_gurobi1000.py  | ts -s "%.s"
echo "1500"
python poek_gurobi1500.py  | ts -s "%.s"
echo "2000"
python poek_gurobi2000.py  | ts -s "%.s"
