import itertools
import poek as pk

model = pk.model()

G = 25
F = 25

d = pk.variable()

y = {}
for i in range(F):
    y[i,1] = pk.variable(lb=0.0, ub=1.0)
    y[i,2] = pk.variable(lb=0.0, ub=1.0)

z = {}
s = {}
r = {}
for i,j,k in itertools.product(range(G), range(G), range(F)):
    z[i,j,k] = pk.variable(binary=True)
    s[i,j,k] = pk.variable(lb=0.0)
    r[i,j,k,1] = pk.variable()
    r[i,j,k,2] = pk.variable()

#obj
model.add(d)

#assmt
for i,j in itertools.product(range(G), range(G)):
    model.add( sum(z[i,j,f] for f in range(F)) == 1 )

M = 2*1.414

#quadrhs
for i,j,f in itertools.product(range(G), range(G), range(F)):
    model.add( s[i,j,f] == d + M*(1 - z[i,j,f]) )

#quaddistk1
for i,j,f in itertools.product(range(G), range(G), range(F)):
    model.add( r[i,j,f,1] == i/G - y[f,1] )
    
#quaddistk2
for i,j,f in itertools.product(range(G), range(G), range(F)):
    model.add( r[i,j,f,2] == j/G - y[f,2] )

#quaddist
for i,j,f in itertools.product(range(G), range(G), range(F)):
    model.add( r[i,j,f,1]**2 + r[i,j,f,2]**2 <= s[i,j,f]**2 )

model.write("foo.lp")
