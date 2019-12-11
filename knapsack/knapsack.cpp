#define _GLIBCXX_USE_CXX11_ABI 0
#include "gurobi_c++.h"
#include <map>
#include <vector>
#include <random>
#include <functional>


int main(int argc, char** argv)
{
GRBEnv env;
GRBModel model(env);

int N = atoi(argv[1])*1000;
double W = N/10.0;

std::mt19937 rng(10000) ;
std::uniform_real_distribution<double> distribution(0,1);
auto uniform = std::bind( distribution, rng );

std::vector<double> v(N);
std::vector<double> w(N);
for (int n=0; n<N; n++) {
    v[n] = uniform();
    w[n] = uniform();
    }

std::vector<GRBVar> x(N);
for (int n=0; n<N; n++)
    x[n] = model.addVar(0,1,0, GRB_CONTINUOUS);

// obj
GRBLinExpr obj;
for (int n=0; n<N; n++)
    obj += v[n]*x[n];
model.setObjective( obj );

// con
GRBLinExpr con;
for (int n=0; n<N; n++)
    con += w[n]*x[n];
model.addConstr( con <= W );


model.getEnv().set(GRB_DoubleParam_TimeLimit, 0);
model.optimize();

return 0;
}
