import sys
import poek as pk

N = int(sys.argv[1])
h = 1.0/N
alpha = 350


model = pk.model()

t = model.getVariable(N+1, lb=-1, ub=1)
x = model.getVariable(N+1, lb=-0.05, ub=0.05)
u = model.getVariable(N+1, initial=0.01)

for i in range(N+1):
    t[i].value = 0.05*cos((i+1)*h)
    x[i].value = 0.05*cos((i+1)*h)

ex = 0
for i in range(N):
    ex += 0.5*h*(u[i+1]**2+u[i]**2) + 0.5*alpha*h*(cos(t[i+1])+cos(t[i]))
model.add( ex )

for i in range(N):
    model.add( x[i+1] - x[i] - (0.5*h)*(sin(t[i+1])+sin(t[i])) == 0 )

for i in range(N):
    model.add( t[i+1] - t[i] - (0.5*h)*u[i+1] - (0.5*h)*u[i] == 0 )


opt = pk.solver('gurobi')
opt.set_option('TimeLimit', 0)
opt.solve(model)
