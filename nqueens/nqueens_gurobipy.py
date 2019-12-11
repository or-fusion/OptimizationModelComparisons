import sys
from gurobipy import *


model = Model("nqueens")

N = int(sys.argv[1])

x = model.addVars(N, N, lb=0.0, ub=1.0, vtype='C')

# obj
model.setObjective( quicksum(x[i,j] for i in range(N) for j in range(N)) )

# one per row
for i in range(N):
    model.addConstr( quicksum(x[i,j] for j in range(N)) == 1 )

# one per column
for j in range(N):
    model.addConstr( quicksum(x[i,j] for i in range(N)) == 1 )

# \diagonals_col
for i in range(N-1):
    model.addConstr( x[0, i] + quicksum(x[j, i+j] for j in range(1, N-i)) <= 1 )
# \diagonals_row
for i in range(1, N-1):
    model.addConstr( x[i, 0] + quicksum(x[i+j, j] for j in range(1, N-i)) <= 1 )

# /diagonals_col
for i in range(1,N):
    model.addConstr( x[0, i] + quicksum(x[j, i-j] for j in range(1, i+1)) <= 1 )
# /diagonals_row
for i in range(1,N-1):
    model.addConstr( x[i, N-1] + quicksum(x[i+j, N-1-j] for j in range(1, N-i)) <= 1)


model.Params.TimeLimit = 0
model.optimize()

