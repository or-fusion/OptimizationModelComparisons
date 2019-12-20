import sys
from pyomo.environ import *
from pyomo.core.expr.numeric_expr import LinearExpression

ones = [1]*int(sys.argv[1])


model = ConcreteModel()

model.N = int(sys.argv[1])

model.Locations = RangeSet(1,model.N)

model.P = int(sys.argv[2])

model.M = model.N

model.Customers = RangeSet(1,model.M)

model.d = Param(model.Locations, model.Customers, initialize=lambda n, m, model : 1.0+1.0/(n+m+1), within=Reals)

model.x = Var(model.Locations, model.Customers, bounds=(0.0,1.0), initialize=0.0)

model.y = Var(model.Locations, bounds=(0.0, 1.0), initialize=0.0)

def rule(model):
    return LinearExpression(linear_coefs=[model.d[n,m] for n in model.Locations for m in model.Customers], linear_vars=[model.x[n,m] for n in model.Locations for m in model.Customers])
model.obj = Objective(rule=rule)

def rule(model, m):
    return (LinearExpression(linear_coefs=ones, linear_vars=[model.x[n,m] for n in model.Locations]), 1.0)
model.single_x = Constraint(model.Customers, rule=rule)

def rule(model, n,m):
    return (None, LinearExpression(linear_coefs=[1,-1], linear_vars=[model.x[n,m], model.y[n]]), 0.0)
model.bound_y = Constraint(model.Locations, model.Customers, rule=rule)

def rule(model):
    return (LinearExpression(linear_coefs=ones, linear_vars=[model.y[n] for n in model.Locations]) - model.P, 0.0)
model.num_facilities = Constraint(rule=rule)
