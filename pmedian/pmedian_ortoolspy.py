import random
import sys
from itertools import product

from ortools.linear_solver import pywraplp

random.seed(1000)

N = int(sys.argv[1])  # Locations
M = N  # Customers
P = int(sys.argv[2])  # Facilities

d = {(n, m): random.uniform(1.0, 2.0) for n, m in product(range(N), range(M))}

solver = pywraplp.Solver('pmedian', pywraplp.Solver.CLP_LINEAR_PROGRAMMING)

x = {key: solver.NumVar(0.0, 1.0, 'x{}'.format(key)) for key in d.keys()}
y = {key: solver.NumVar(0.0, 1.0, 'y{}'.format(key)) for key in range(N)}

# obj
objective = solver.Objective()
objective.SetMinimization()
for key, val in d.items():
    objective.SetCoefficient(x[key], val)

# single_x
for m in range(M):
    solver.Add(solver.Sum(x[n, m] for n in range(N)) == 1)

# bound_y
for n, m in product(range(N), range(M)):
    solver.Add(x[n, m] - y[n] <= 0)

# num_facilities
solver.Add(solver.Sum(y[n] for n in range(N)) == P)

# Time limit doesn't work if 0.
# See: https://github.com/google/or-tools/issues/1763
solver.SetTimeLimit(1)
solver.Solve()