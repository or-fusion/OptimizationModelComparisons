import sys
import random
from gurobipy import *

random.seed(1000)

N = int(sys.argv[1])*1000
W = N/10.0

model = Model("knapsack")

w = {}
v = {}
for i in range(N):
    w[i] = random.uniform(0.0,1.0)
    v[i] = random.uniform(0.0,1.0)

x = model.addVars(N, lb=0.0, ub=1.0, vtype='C')

model.setObjective( quicksum(v[i]*x[i] for i in range(N)) )

model.addConstr( quicksum(w[i]*x[i] for i in range(N)) <= W )


model.Params.TimeLimit = 0
model.optimize()

