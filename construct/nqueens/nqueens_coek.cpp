#include <map>
#include <vector>
#include "coek_model.hpp"


int main(int argc, char** argv)
{
int N = atoi(argv[1]);

coek::Model model;

std::vector<std::vector<coek::Variable>> x(N, std::vector<coek::Variable>(N));
for (int i=0; i<N; i++)
    for (int j=0; j<N; j++)
        x[i][j] = model.getVariable(0,1,0,true,false);

// obj
coek::Expression obj;
for (int i=0; i<N; i++)
    for (int j=0; j<N; j++)
        obj += x[i][j];
model.add( obj );

// one per row
for (int i=0; i<N; i++) {
    coek::Expression c;
    for (int j=0; j<N; j++)
        c += x[i][j];
    model.add( c == 1 );
    }

// one per column
for (int j=0; j<N; j++) {
    coek::Expression c;
    for (int i=0; i<N; i++)
        c += x[i][j];
    model.add( c == 1 );
    }

// \diagonals_col
for (int i=0; i<N-1; i++) {
    coek::Expression c;
    c += x[0][i];
    for (int j=1; j<N-i; j++)
        c += x[j][i+j];
    model.add( c <= 1 );
    }
// \diagonals_row
for (int i=1; i<N-1; i++) {
    coek::Expression c;
    c += x[i][0];
    for (int j=1; j<N-i; j++)
        c += x[i+j][j];
    model.add( c <= 1 );
    }

// /diagonals_col
for (int i=1; i<N; i++) {
    coek::Expression c;
    c += x[0][i];
    for (int j=1; j<=i; j++)
        c += x[j][i-j];
    model.add( c <= 1 );
    }
// /diagonals_row
for (int i=1; i<N-1; i++) {
    coek::Expression c;
    c += x[i][N-1];
    for (int j=1; j<N-i; j++)
        c += x[i+j][N-1-j];
    model.add( c <= 1 );
    }

coek::Solver opt;
opt.initialize("gurobi");
opt.set_option("TimeLimit", 0);
opt.solve(model);

return 0;
}


