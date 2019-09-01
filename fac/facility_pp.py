import sys
import poek as pk
import poek.util

import facility_pyomo


model = pk.model()
pk.util.pyomo_to_poek(facility_pyomo.model, model)

opt = pk.solver('gurobi')
opt.set_option('TimeLimit', 0)
opt.solve(model)
