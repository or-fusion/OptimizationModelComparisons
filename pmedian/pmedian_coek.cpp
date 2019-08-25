#include <map>
#include <vector>
#include <random>
#include <functional>
#include "coek_model.hpp"


int main(int argc, char** argv)
{
int N = atoi(argv[1]);  // Locations
int M = N;              // Customers
int P = atoi(argv[2]);  // Facilities

std::mt19937 rng(10000) ;
std::uniform_real_distribution<double> distribution(1,2);
auto uniform = std::bind( distribution, rng );

coek::Model model;

std::vector<std::vector<double>> d(N, std::vector<double>(M));
for (int n=0; n<N; n++)
    for (int m=0; m<M; m++)
        d[n][m] = uniform();

std::vector<std::vector<coek::Variable>> x(N, std::vector<coek::Variable>(M));
for (int n=0; n<N; n++)
    for (int m=0; m<M; m++)
        x[n][m] = model.getVariable(0,1,0);

std::vector<coek::Variable> y(N);
for (int n=0; n<N; n++)
    y[n] = model.getVariable(0,1,0);

// obj
coek::Expression obj;
for (int n=0; n<N; n++)
    for (int m=0; m<M; m++)
        obj += d[n][m]*x[n][m];
model.add( obj );

// single_x
for (int m=0; m<M; m++) {
    coek::Expression c;
    for (int n=0; n<N; n++)
        c += x[n][m];
    model.add( c == 1 );
    }

// bound_y
for (int n=0; n<N; n++)
    for (int m=0; m<M; m++)
        model.add( x[n][m] - y[n] <= 0 );

// num_facilities
coek::Expression num_facilities;
for (int n=0; n<N; n++)
    num_facilities += y[n];
model.add( num_facilities == P );


coek::Solver opt;
opt.initialize("gurobi");
opt.set_option("TimeLimit", 0);
opt.solve(model);

return 0;
}
