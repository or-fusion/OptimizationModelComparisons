#!/bin/sh

# NOTE: Writing an LP file is a lower bound on the runtime
#       of Pyomo with GURBOI.  But Pyomo buffers
#       the solver I/O.
#
time (pyomo convert pyomo500.py --output=foo.lp  ; gurobi_cl timelimit=0 foo.lp)
time (pyomo convert pyomo1000.py --output=foo.lp ; gurobi_cl timelimit=0 foo.lp)
time (pyomo convert pyomo1500.py --output=foo.lp ; gurobi_cl timelimit=0 foo.lp)
time (pyomo convert pyomo2000.py --output=foo.lp ; gurobi_cl timelimit=0 foo.lp)
