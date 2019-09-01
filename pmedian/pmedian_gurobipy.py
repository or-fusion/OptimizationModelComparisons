import sys
import random
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

x = model.addVars(N, M, lb=0.0, ub=1.0, vtype='B')

y = model.addVars(N, lb=0.0, ub=1.0, vtype='B')

# obj
model.setObjective( quicksum(d[n,m]*x[n,m] for n in range(N) for m in range(M)) )

# single_x
for m in range(M):
    model.addConstr( quicksum(x[n,m] for n in range(N)) == 1 )

# bound_y
for n,m in itertools.product(range(N), range(M)):
    model.addConstr( x[n,m] - y[n] <= 0 )

# num_facilities
model.addConstr( quicksum(y[n] for n in range(N)) == P )


model.Params.TimeLimit = 0
model.optimize()

