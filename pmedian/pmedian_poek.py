import sys
import random
import itertools
import poek as pk

random.seed(1000)


model = pk.model()

N = int(sys.argv[1])    # Locations
M = N                   # Customers
P = int(sys.argv[2])    # Facilities

d = {}
for n in range(N):
    for m in range(M):
        d[n,m] = random.uniform(1.0,2.0)

x = pk.variable((N,M), lb=0.0, ub=1.0, initial=0.0)
y = pk.variable(N, lb=0.0, ub=1.0, initial=0.0)
model.use(x)
model.use(y)

# obj
model.add( sum(d[n,m]*x[n,m] for n in range(N) for m in range(M)) )

# single_x
for m in range(M):
    model.add( sum(x[n,m] for n in range(N)) == 1 )

# bound_y
for n,m in itertools(range(N), range(M)):
    model.add( x[n,m] - y[n] <= 0 )

# num_facilities
model.add( sum(y[n] for n in range(N)) == P )
