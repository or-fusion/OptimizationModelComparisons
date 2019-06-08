#!/bin/sh

# NOTE: Writing an LP file is a lower bound on the runtime
#       of Pyomo with GURBOI.  But Pyomo buffers
#       the solver I/O.
#
pyomo convert pyomo25.py --output=foo.lp  | ts -s
pyomo convert pyomo50.py --output=foo.lp  | ts -s
pyomo convert pyomo75.py --output=foo.lp  | ts -s
pyomo convert pyomo100.py --output=foo.lp  | ts -s
