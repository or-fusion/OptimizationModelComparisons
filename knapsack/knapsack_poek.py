import sys
import random
import itertools
import poek as pk

random.seed(1000)

N = int(sys.argv[1])
W = N/10.0


model = pk.model()

w = {}
v = {}
for i in range(N):
    w[i] = random.uniform(0.0,1.0)
    v[i] = random.uniform(0.0,1.0)

x = pk.variable(N, lb=0.0, ub=1.0)

model.add( pk.quicksum(v[i]*x[i] for i in range(N)) )
model.add( pk.quicksum(w[i]*x[i] for i in range(N)) <= W )


opt = pk.solver('gurobi')
opt.set_option('TimeLimit', 0)
opt.solve(model)
