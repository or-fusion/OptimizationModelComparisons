import sys
import random
import itertools
from gurobipy import *

random.seed(1000)


model = Model("pmedian")

N = int(sys.argv[1])    # Locations
M = N                   # Customers
P = int(sys.argv[2])    # Facilities

d = {}
for n in range(N):
    for m in range(M):
        d[n,m] = random.uniform(1.0,2.0)

#addVars()
x = {}
for n in range(N):
    for m in range(M):
        x[n,m] = model.addVar(vtype=GRB.BINARY, name="x")
        #x = gurobi.variable((N,M), lb=0.0, ub=1.0, initial=0.0)

y = {}
for n in range(N):
    y[n] = model.addVar(vtype=GRB.BINARY, name="x")
    #y = gurobi.variable(N, lb=0.0, ub=1.0, initial=0.0)

# obj
model.setObjective( sum(d[n,m]*x[n,m] for n in range(N) for m in range(M)) )

# single_x
for m in range(M):
    model.addConstr( sum(x[n,m] for n in range(N)) == 1 )

# bound_y
for n,m in itertools.product(range(N), range(M)):
    model.addConstr( x[n,m] - y[n] <= 0 )

# num_facilities
model.addConstr( sum(y[n] for n in range(N)) == P )


model.optimize()

opt = gurobi.solver('gurobi')
opt.set_option('TimeLimit', 0)
opt.solve(model)
