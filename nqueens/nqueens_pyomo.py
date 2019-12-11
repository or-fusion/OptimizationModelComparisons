import sys
from pyomo.environ import *


model = ConcreteModel()

N = int(sys.argv[1])

model.Rows = RangeSet(0,N-1)
model.Cols = RangeSet(0,N-1)

model.x = Var(model.Rows, model.Cols, within=Boolean)


# obj
model.obj = Objective(expr=sum( model.x[i,j] for i in model.Rows for j in model.Cols) )

# one per row
def row_rule(model, i):
    return sum(model.x[i,j] for j in range(N)) == 1
model.row_rule = Constraint(model.Rows, rule=row_rule)

def col_rule(model, j):
    return sum(model.x[i,j] for i in range(N)) == 1
model.col_rule = Constraint(model.Cols, rule=col_rule)

# \diagonals_col
def ldiag_cols_rule(model, i):
    return model.x[0, i] + sum(model.x[j, i+j] for j in range(1, N-i)) <= 1
model.ldiag_cols = Constraint(range(N-1), rule=ldiag_cols_rule)

# \diagonals_row
def ldiag_rows_rule(model, i):
    return model.x[i, 0] + sum(model.x[i+j, j] for j in range(1, N-i)) <= 1
model.ldiag_rows = Constraint(range(1, N-1), rule=ldiag_rows_rule)

# /diagonals_col
def rdiag_cols_rule(model, i):
    return model.x[0, i] + sum(model.x[j, i-j] for j in range(1, i+1)) <= 1
model.rdiag_cols = Constraint(range(1,N), rule=rdiag_cols_rule)

# /diagonals_row
def rdiag_rows_rule(model, i):
    return model.x[i, N-1] + sum(model.x[i+j, N-1-j] for j in range(1, N-i)) <= 1
model.rdiag_rows = Constraint(range(1,N-1), rule=rdiag_rows_rule)
