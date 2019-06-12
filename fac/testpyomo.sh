#!/bin/sh

# NOTE: Writing an LP file is a lower bound on the runtime
#       of Pyomo with GURBOI.  But Pyomo buffers
#       the solver I/O.
#
time (pyomo convert pyomo25.py --output=foo.lp  ; gurobi_cl timelimit=0 foo.lp)
time (pyomo convert pyomo50.py --output=foo.lp  ; gurobi_cl timelimit=0 foo.lp)
time (pyomo convert pyomo75.py --output=foo.lp  ; gurobi_cl timelimit=0 foo.lp)
time (pyomo convert pyomo100.py --output=foo.lp ; gurobi_cl timelimit=0 foo.lp)
