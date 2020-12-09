#include <map>
#include <vector>
#include <random>
#include <functional>
#include <coek/coek.hpp>


int main(int argc, char** argv)
{
int N = 1000*atoi(argv[1]);
double h = 1.0/N;
double alpha = 350;


coek::Model model;

std::vector<coek::Variable> t(N+1);
std::vector<coek::Variable> u(N+1);
std::vector<coek::Variable> x(N+1);
for (int i=0; i<N+1; i++)
    t[i] = model.add_variable(-1, 1, 0.05*cos((i+1)*h));
for (int i=0; i<N+1; i++)
    u[i] = model.add_variable(-COEK_INFINITY, COEK_INFINITY, 0.01);
for (int i=0; i<N+1; i++)
    x[i] = model.add_variable(-0.05, 0.05, 0.05*cos((i+1)*h));

coek::Expression obj;
for (int i=0; i<N; i++)
    obj += 0.5*h*(pow(u[i+1],2)+pow(u[i],2)) + 0.5*alpha*h*(cos(t[i+1])+cos(t[i]));
model.add_objective( obj );

for (int i=0; i<N; i++)
    model.add_constraint( x[i+1] - x[i] - (0.5*h)*(sin(t[i+1])+sin(t[i])) == 0 );

for (int i=0; i<N; i++)
    model.add_constraint( t[i+1] - t[i] - (0.5*h)*u[i+1] - (0.5*h)*u[i] == 0 );

coek::NLPSolver opt;
opt.initialize("ipopt");
opt.set_option("max_cpu_time", 1.0);
auto _model = coek::NLPModel(model, "cppad");
opt.solve(_model);

return 0;
}
