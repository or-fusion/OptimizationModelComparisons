import sys
from pyomo.environ import *
import random

random.seed(1000)

N = int(sys.argv[1])
W = N/10.0


model = ConcreteModel()

model.INDEX = RangeSet(1,N)

model.w = Param(model.INDEX, initialize=lambda model, i : random.uniform(0.0,1.0), within=Reals)

model.v = Param(model.INDEX, initialize=lambda model, i : random.uniform(0.0,1.0), within=Reals)

model.x = Var(model.INDEX, bounds=(0.0,1.0))

model.o = Objective(expr=sum(model.w[i]*model.x[i] for i in model.INDEX))

model.c = Constraint(expr=sum(model.v[i]*model.x[i] for i in model.INDEX) <= W)
