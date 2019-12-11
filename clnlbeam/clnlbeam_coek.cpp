#include <map>
#include <vector>
#include <random>
#include <functional>
#include "coek_model.hpp"


int main(int argc, char** argv)
{
int N = atoi(argv[1]);
double h = 1.0/N;
double alpha = 350;


coek::Model model;

std::vector<coek::Variable> t(N+1);
std::vector<coek::Variable> x(N+1);
std::vector<coek::Variable> u(N+1);
for (int i=0; i<N; i++) {
    t[i] = model.getVariable(-1, 1, 0.05*cos((i+1)*h));
    x[i] = model.getVariable(-0.05, 0.05, 0.05*cos((i+1)*h));
    u[i] = model.getVariable(-COEK_INFINITY, COEK_INFINITY, 0.01);
    }

coek::Expression obj;
for (int i=0; i<N; i++)
    obj += 0.5*h*(pow(u[i+1],2)+pow(u[i],2)) + 0.5*alpha*h*(cos(t[i+1])+cos(t[i]));
model.add( obj );

for (int i=0; i<N; i++)
    model.add( x[i+1] - x[i] - (0.5*h)*(sin(t[i+1])+sin(t[i])) == 0 );

for (int i=0; i<N; i++)
    model.add( t[i+1] - t[i] - (0.5*h)*u[i+1] - (0.5*h)*u[i] == 0 );

coek::Solver opt;
opt.initialize("ipopt");
opt.set_option("TimeLimit", 0);
opt.solve(model);

return 0;
}
