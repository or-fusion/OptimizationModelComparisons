import random
import sys

from pulp import GUROBI, LpMaximize, LpProblem, LpVariable, lpSum

random.seed(1000)

N = int(sys.argv[1]) * 1000
W = N / 10.0

model = LpProblem("knapsack", LpMaximize)

# Weights
w = {i: random.uniform(0.0, 1.0) for i in range(N)}
# Values
v = {i: random.uniform(0.0, 1.0) for i in range(N)}

x = LpVariable.dicts("x", v.keys(), lowBound=0.0, upBound=1.0, cat='Continuous')

# Objective Function
model += lpSum(val * x[key] for key, val in v.items())
# Capacity
model += lpSum(val * x[key] for key, val in w.items()) <= W

model.solve(solver=GUROBI(**{"TimeLimit": 0}))
