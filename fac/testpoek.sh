#!/bin/sh

# NOTE: Writing an LP file is a lower bound on the runtime
#       of Poek with GURBOI.

time (python poek25.py;  gurobi_cl timelimit=0 foo.lp)
time (python poek50.py;  gurobi_cl timelimit=0 foo.lp)
time (python poek75.py;  gurobi_cl timelimit=0 foo.lp)
time (python poek100.py; gurobi_cl timelimit=0 foo.lp)
