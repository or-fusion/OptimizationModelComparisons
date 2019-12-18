import sys
from itertools import product

from gurobipy import Model

model = Model("fac")

F = int(sys.argv[1])
G = F
G_ = G + 1

d = model.addVar(vtype='C')
y = model.addVars(F, 2, vtype='C', lb=0.0, ub=1.0)
z = model.addVars(G_, G_, F, vtype='B')
s = model.addVars(G_, G_, F, vtype='C', lb=0.0)
r = model.addVars(G_, G_, F, 2, vtype='C')

# obj
model.setObjective(d)

# assmt
model.addConstrs(
    (z.sum(i, j, '*') == 1) for i, j in product(range(G_), range(G_)))

M = 2 * 1.414

# quadrhs
model.addConstrs((s[i, j, f] == d + M * (1 - z[i, j, f])
                  for i, j, f in product(range(G_), range(G_), range(F))))

# quaddistk1
model.addConstrs((r[i, j, f, 0] == i / G - y[f, 0]
                  for i, j, f in product(range(G_), range(G_), range(F))))

# quaddistk2
model.addConstrs(r[i, j, f, 1] == j / G - y[f, 1]
                 for i, j, f in product(range(G_), range(G_), range(F)))

# quaddist
model.addConstrs((r[i, j, f, 0] * r[i, j, f, 0] + r[i, j, f, 1] * r[i, j, f, 1]
                  <= s[i, j, f] * s[i, j, f]
                  for i, j, f in product(range(G_), range(G_), range(F))))

model.Params.TimeLimit = 0
model.optimize()
