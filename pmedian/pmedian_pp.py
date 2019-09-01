import sys
import poek as pk

import pmedian_pyomo


model = pk.model()
pk.pyomo_to_poek(pmedian_pyomo.model, model)

opt = pk.solver('gurobi')
opt.set_option('TimeLimit', 0)
opt.solve(model)
