#!/bin/sh

# NOTE: Writing an LP file is a lower bound on the runtime
#       of Pyomo with GURBOI.  But Pyomo buffers
#       the solver I/O.

time (python facility_pyomo.py  25 ; gurobi_cl timelimit=0 pyomo.lp)
time (python facility_pyomo.py  50 ; gurobi_cl timelimit=0 pyomo.lp)
time (python facility_pyomo.py  75 ; gurobi_cl timelimit=0 pyomo.lp)
time (python facility_pyomo.py 100 ; gurobi_cl timelimit=0 pyomo.lp)
