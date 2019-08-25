#!/bin/sh

# NOTE: Writing an LP file is a lower bound on the runtime
#       of Pyomo with GURBOI.  But Pyomo buffers
#       the solver I/O.

time (python pmedian_pyomo.py  160 1 ; gurobi_cl timelimit=0 pyomo.lp)
time (python pmedian_pyomo.py  320 1 ; gurobi_cl timelimit=0 pyomo.lp)
time (python pmedian_pyomo.py  640 1 ; gurobi_cl timelimit=0 pyomo.lp)
time (python pmedian_pyomo.py 1280 1 ; gurobi_cl timelimit=0 pyomo.lp)
