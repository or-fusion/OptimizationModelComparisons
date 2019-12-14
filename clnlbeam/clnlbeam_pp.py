import sys
import poek as pk
import poek.util

import clnlbeam_pyomo


model = pk.model()
pkmodel = pk.util.pyomo_to_poek(clnlbeam_pyomo.model)

opt = pk.solver('ipopt')
opt.set_option('TimeLimit', 0)
opt.solve(pkmodel)
