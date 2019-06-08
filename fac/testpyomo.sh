#!/bin/sh

# NOTE: Writing an LP file is a lower bound on the runtime
#       of Pyomo with GURBOI.  But Pyomo buffers
#       the solver I/O.
#
pyomo convert facility25.py --output=foo.lp  | ts -s
pyomo convert facility50.py --output=foo.lp  | ts -s
pyomo convert facility75.py --output=foo.lp  | ts -s
pyomo convert facility100.py --output=foo.lp  | ts -s
