#!/bin/sh

# NOTE: Writing an LP file is a lower bound on the runtime
#       of Poek with GURBOI.

time (python poek500.py  ; gurobi_cl timelimit=0 foo.lp)
time (python poek1000.py ; gurobi_cl timelimit=0 foo.lp)
time (python poek1500.py ; gurobi_cl timelimit=0 foo.lp)
time (python poek2000.py ; gurobi_cl timelimit=0 foo.lp)
