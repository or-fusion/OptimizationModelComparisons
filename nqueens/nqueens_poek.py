import sys
import itertools
import poek as pk
quicksum = pk.quicksum


model = pk.model()

N = int(sys.argv[1])

x = pk.variable((N,N), lb=0.0, ub=1.0, binary=True)
model.use(x)

# obj
model.add( quicksum(x[i,j] for i in range(N) for j in range(N)) )

# one per row
for i in range(N):
    model.add( quicksum(x[i,j] for j in range(N)) == 1 )

# one per column
for j in range(N):
    model.add( quicksum(x[i,j] for i in range(N)) == 1 )

# \diagonals_col
for i in range(N-1):
    model.add( x[0, i] + quicksum(x[j, i+j] for j in range(1, N-i)) <= 1 )
# \diagonals_row
for i in range(1, N-1):
    model.add( x[i, 0] + quicksum(x[i+j, j] for j in range(1, N-i)) <= 1 )

# /diagonals_col
for i in range(1,N):
    model.add( x[0, i] + quicksum(x[j, i-j] for j in range(1, i+1)) <= 1 )
# /diagonals_row
for i in range(1,N-1):
    model.add( x[i, N-1] + quicksum(x[i+j, N-1-j] for j in range(1, N-i)) <= 1)


opt = pk.solver('gurobi')
opt.set_option('TimeLimit', 0)
opt.solve(model)
