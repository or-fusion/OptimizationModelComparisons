import sys

from pulp import GUROBI, LpMinimize, LpProblem, LpVariable, lpSum

model = LpProblem("pmedian", LpMinimize)

N = int(sys.argv[1])  # Locations
M = N                 # Customers
P = int(sys.argv[2])  # Facilities

d = {(n, m): 1.0+1.0/(n+m+1) for n in range(N) for m in range(M)}

x = LpVariable.dicts("x", d.keys(), lowBound=0.0, upBound=1.0, cat="Continuous")

y = LpVariable.dicts("y", range(N), lowBound=0.0, upBound=1.0, cat="Continuous")

# obj
model += lpSum(x[(key[0], key[1])] * val for key, val in d.items())

# single_x
for m in range(M):
    model += lpSum(x[(n, m)] for n in range(N)) == 1

# bound_y
for n in range(N):
    for m in range(M):
        model += lpSum(x[(n, m)] - y[n]) <= 0

# num_facilities
model += lpSum([y[n] for n in range(N)]) == P

model.solve(solver=GUROBI(**{"TimeLimit": 0}))
