import sys
import poek as pk
import poek.util

import pmedian_pyomo


model = pk.model()
pk.util.pyomo_to_poek(pmedian_pyomo.model, model)

opt = pk.solver('gurobi')
opt.set_option('TimeLimit', 0)
opt.solve(model)
