import sys
import itertools
from gurobipy import *

model = Model("lqcp")

n = int(sys.argv[1])
m = n
dx = 1.0/n
T = 1.58
dt = T/n
h2 = dx**2
a = 0.001

y = model.addVars(n+1,m+1, vtype='C', lb=0.0, ub=1.0)
u = model.addVars(n+1, vtype='C', lb=-1.0, ub=1.0)

def yt(j, dx):
    return 0.5*(1 - (j*dx)*(j*dx))

#obj
model.setObjective(0.25*dx*(
        (y[m, 0] - yt(0, dx))*(y[m,0] - yt(0, dx)) +
        2*quicksum((y[m, j] - yt(j, dx))*(y[m, j] - yt(j, dx)) for j in range(1, n)) +
        (y[m, n] - yt(n, dx))*(y[m, n] - yt(n, dx))
    ) + 0.25*a*dt*(
        2 * quicksum(u[i]*u[i] for i in range(1, m)) +
        u[m]*u[m]
    ))

#pde
for i, j in itertools.product(range(n), range(1, m)):
    model.addConstr((y[i+1, j] - y[i, j])/dt == 0.5*(y[i, j-1] - 2*y[i, j] + y[i, j+1] + y[i+1, j-1] - 2*y[i+1, j] + y[i+1, j+1])/h2)

#ic
for j in range(m+1):
    model.addConstr(y[0, j] == 0)

#bc1
for i in range(1, n+1):
    model.addConstr(y[i, 2] - 4*y[i, 1] + 3*y[i, 0] == 0)

#bc2
for i in range(1, n+1):
    model.addConstr(y[i, n-2] - 4*y[i, n-1] + 3*y[i, n-0] == (2*dx)*(u[i] - y[i, n-0]))


model.Params.TimeLimit = 0
model.optimize()
