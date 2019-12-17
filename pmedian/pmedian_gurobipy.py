import sys
import random
from gurobipy import Model

random.seed(1000)

model = Model("pmedian")

N = int(sys.argv[1])  # Locations
M = N  # Customers
P = int(sys.argv[2])  # Facilities

d = {(n, m): random.uniform(1.0, 2.0) for n in range(N) for m in range(M)}

x = model.addVars(d.keys(), lb=0.0, ub=1.0, vtype='C')

y = model.addVars(N, lb=0.0, ub=1.0, vtype='C')

# obj
model.setObjective(x.prod(d))

# single_x
model.addConstrs((x.sum('*', m) == 1 for m in range(M)))

# bound_y
model.addConstrs((x[n, m] - y[n] <= 0 for n in range(N) for m in range(M)))

# num_facilities
model.addConstr(y.sum('*') == P)

model.Params.TimeLimit = 0
model.optimize()
