import sys
import itertools
import poek as pk
quicksum = pk.quicksum


model = pk.model()

N = int(sys.argv[1])    # Locations
M = N                   # Customers
P = int(sys.argv[2])    # Facilities

d = {}
for n in range(N):
    for m in range(M):
        d[n,m] = 1.0+1.0/(n+m+1)

x = pk.variable((N,M), lb=0.0, ub=1.0, initial=0.0)
y = pk.variable(N, lb=0.0, ub=1.0, initial=0.0)
model.use(x)
model.use(y)

# obj
model.add( quicksum(d[n,m]*x[n,m] for n in range(N) for m in range(M)) )

# single_x
for m in range(M):
    model.add( quicksum(x[n,m] for n in range(N)) == 1 )

# bound_y
for n,m in itertools.product(range(N), range(M)):
    model.add( x[n,m] - y[n] <= 0 )

# num_facilities
model.add( quicksum(y[n] for n in range(N)) == P )


opt = pk.solver('gurobi')
opt.set_option('TimeLimit', 0)
opt.solve(model)
