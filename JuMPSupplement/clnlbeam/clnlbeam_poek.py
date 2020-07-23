import sys
import math
import poek as pk

N = 1000*int(sys.argv[1])
h = 1.0/N
alpha = 350


model = pk.model()

t = pk.variable(N+1, lb=-1, ub=1)
u = pk.variable(N+1, initial=0.01)
x = pk.variable(N+1, lb=-0.05, ub=0.05)
model.use(t)
model.use(u)
model.use(x)

for i in range(N+1):
    t[i].initial = 0.05*math.cos((i+1)*h)
    x[i].initial = 0.05*math.cos((i+1)*h)

ex = 0
for i in range(N):
    ex += 0.5*h*(u[i+1]**2+u[i]**2) + 0.5*alpha*h*(pk.cos(t[i+1])+pk.cos(t[i]))
model.add( ex )

for i in range(N):
    model.add( x[i+1] - x[i] - (0.5*h)*(pk.sin(t[i+1])+pk.sin(t[i])) == 0 )

for i in range(N):
    model.add( t[i+1] - t[i] - (0.5*h)*u[i+1] - (0.5*h)*u[i] == 0 )


opt = pk.nlp_solver('ipopt')
opt.set_option('max_cpu_time', 1.0)
_model = pk.nlp_model(model, "cppad")
opt.solve(_model)
