#!/bin/sh

# NOTE: Writing an LP file is a lower bound on the runtime
#       of Pyomo with GURBOI.  But Pyomo buffers
#       the solver I/O.
#
time (pyomo pyomo.py  500 ; gurobi_cl timelimit=0 pyomo.lp)
time (pyomo pyomo.py 1000 ; gurobi_cl timelimit=0 pyomo.lp)
time (pyomo pyomo.py 1500 ; gurobi_cl timelimit=0 pyomo.lp)
time (pyomo pyomo.py 2000 ; gurobi_cl timelimit=0 pyomo.lp)
