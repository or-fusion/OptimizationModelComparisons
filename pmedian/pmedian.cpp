#define _GLIBCXX_USE_CXX11_ABI 0
#include "gurobi_c++.h"
#include <map>
#include <vector>
#include <random>


int main(int argc, char** argv)
{
GRBEnv env;
GRBModel model(env);

int N = atoi(argv[1]);  // Locations
int M = N;              // Customers
int P = atoi(argv[2]);  // Facilities

std::mt19937 rng(10000) ;
std::uniform_int_distribution<double> distribution(1,2);
auto uniform = std::bind( distribution, rng );

std::vector<std::vector<double>> d(N, std::vector<double>(M));
for (int n=0; n<N; n++)
    for (int m=0; m<M; m++)
        d[n,m] = uniform();

std::vector<std::vector<GRBVar>> x(N, std::vector<GRBVar>(M));
for (int n=0; n<N; n++)
    for (int m=0; m<M; m++)
        x[n,m] = model.addVar(0,1,0, GRB_CONTINUOUS);

std::vector<GRBVar> y(N);
for (int n=0; n<N; n++)
    y[n] = model.addVar(0,1,0, GRB_CONTINUOUS);

// obj
GRBLinearExpr obj;
for (int n=0; n<N; n++)
    for (int m=0; m<M; m++)
        obj += d[n,m]*x[n,m];
model.setObjective( obj );

// single_x
for (int m=0; m<M; m++) {
    GRBLinearExpr c;
    for (int n=0; n<N; n++)
        c += x[n,m];
    model.addConstr( c == 1 );
    }

// bound_y
for (int n=0; n<N; n++)
    for (int m=0; m<M; m++)
        model.addConstr( x[n,m] - y[n] <= 0 );

// num_facilities
GRBLinearExpr num_facilities;
for (int n=0; n<N; n++)
    num_facilities += y[n];
model.addConstr( num_facilities == P );


model.getEnv().set(GRB_DoubleParam_TimeLimit, 0);
model.optimize();

return 0;
}
