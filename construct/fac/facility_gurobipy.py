import sys
import itertools
from gurobipy import *


model = Model("fac")

F = int(sys.argv[1])
G = F
G_ = G+1

d = model.addVar(vtype='C')
y = model.addVars(F,2, vtype='C', lb=0.0, ub=1.0)
z = model.addVars(G_,G_,F, vtype='B')
s = model.addVars(G_,G_,F, vtype='C', lb=0.0)
r = model.addVars(G_,G_,F,2, vtype='C')

#obj
model.setObjective(d)

#assmt
for i,j in itertools.product(range(G_), range(G_)):
    model.addConstr( quicksum(z[i,j,f] for f in range(F)) == 1 )

M = 2*1.414

#quadrhs
for i,j,f in itertools.product(range(G_), range(G_), range(F)):
    model.addConstr( s[i,j,f] == d + M*(1 - z[i,j,f]) )

#quaddistk1
for i,j,f in itertools.product(range(G_), range(G_), range(F)):
    model.addConstr( r[i,j,f,0] == i/G - y[f,0] )
    
#quaddistk2
for i,j,f in itertools.product(range(G_), range(G_), range(F)):
    model.addConstr( r[i,j,f,1] == j/G - y[f,1] )

#quaddist
for i,j,f in itertools.product(range(G_), range(G_), range(F)):
    model.addConstr( r[i,j,f,0]*r[i,j,f,0] + r[i,j,f,1]*r[i,j,f,1] <= s[i,j,f]*s[i,j,f] )


model.Params.TimeLimit = 0
model.optimize()
