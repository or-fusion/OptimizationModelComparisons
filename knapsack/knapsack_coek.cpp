#include <map>
#include <vector>
#include <random>
#include <functional>
#include "coek_model.hpp"


int main(int argc, char** argv)
{
int N = atoi(argv[1]);
double W = N/10.0;

std::mt19937 rng(10000) ;
std::uniform_real_distribution<double> distribution(1,2);
auto uniform = std::bind( distribution, rng );

std::vector<double> v(N);
std::vector<double> w(N);
for (int n=0; n<N; n++) {
    v[n] = uniform();
    w[n] = uniform();
    }

coek::Model model;

std::vector<coek::Variable> x(N);
for (int n=0; n<N; n++)
    x[n] = model.getVariable(0,1,0);

// obj
coek::Expression obj;
for (int n=0; n<N; n++)
    obj += v[n]*x[n];
model.add( obj );

// con
coek::Expression con;
for (int n=0; n<N; n++)
    con += w[n]*x[n];
model.add( con <= W );


coek::Solver opt;
opt.initialize("gurobi");
opt.set_option("TimeLimit", 0);
opt.solve(model);

return 0;
}
