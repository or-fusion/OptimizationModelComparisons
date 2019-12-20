#define _GLIBCXX_USE_CXX11_ABI 0
#include "gurobi_c++.h"
#include <map>
#include <vector>


int main(int argc, char** argv)
{
GRBEnv env;
GRBModel model(env);

int N = atoi(argv[1]);  // Locations

std::vector<std::vector<GRBVar>> x(N, std::vector<GRBVar>(N));
for (int i=0; i<N; i++)
    for (int j=0; j<N; j++)
        x[i][j] = model.addVar(0,1,0,GRB_BINARY);

// obj
GRBLinExpr obj;
for (int i=0; i<N; i++)
    for (int j=0; j<N; j++)
        obj += x[i][j];
model.setObjective( obj );

// one per row
for (int i=0; i<N; i++) {
    GRBLinExpr c;
    for (int j=0; j<N; j++)
        c += x[i][j];
    model.addConstr( c == 1 );
    }

// one per column
for (int j=0; j<N; j++) {
    GRBLinExpr c;
    for (int i=0; i<N; i++)
        c += x[i][j];
    model.addConstr( c == 1 );
    }

// \diagonals_col
for (int i=0; i<N-1; i++) {
    GRBLinExpr c;
    c += x[0][i];
    for (int j=1; j<N-i; j++)
        c += x[j][i+j];
    model.addConstr( c <= 1 );
    }
// \diagonals_row
for (int i=1; i<N-1; i++) {
    GRBLinExpr c;
    c += x[i][0];
    for (int j=1; j<N-i; j++)
        c += x[i+j][j];
    model.addConstr( c <= 1 );
    }

// /diagonals_col
for (int i=1; i<N; i++) {
    GRBLinExpr c;
    c += x[0][i];
    for (int j=1; j<=i; j++)
        c += x[j][i-j];
    model.addConstr( c <= 1 );
    }
// /diagonals_row
for (int i=1; i<N-1; i++) {
    GRBLinExpr c;
    c += x[i][N-1];
    for (int j=1; j<N-i; j++)
        c += x[i+j][N-1-j];
    model.addConstr( c <= 1 );
    }


model.getEnv().set(GRB_DoubleParam_TimeLimit, 0);
model.optimize();

return 0;
}
