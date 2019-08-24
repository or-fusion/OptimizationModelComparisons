#include "coek_model.hpp"
#include <cmath>
#include <cstdlib>
#include <vector>
using namespace std;


int main(int argc, char *argv[])
{
    // Load commandline arguments
    const int G = atoi(argv[1]);
    const int F = atoi(argv[1]);
    cout << "G: " << G << ", F: " << F << endl;

    coek::Model model;

    // Create variables
    coek::Variable d(0, COEK_INFINITY, 1.0);
    
    vector<vector<coek::Variable> > y;
    for (int f = 0; f < F; f++) {
        y.push_back(vector<coek::Variable>());
        for (int k = 0; k < 2; k++) {
            y[f].push_back(
                model.getVariable(0, 1, 0)
                );
        }
    }

    vector<vector<vector<coek::Variable>>> z;
    for (int i = 0; i <= G; i++) {
        z.push_back(vector<vector<coek::Variable>>());
        for (int j = 0; j <= G; j++) {
            z[i].push_back(vector<coek::Variable>());
            for (int f = 0; f < F; f++) {
                z[i][j].push_back(
                    model.getVariable(0, 1, 0, true)
                );
            }
        }
    }

    vector<vector<vector<coek::Variable>>> s;
    for (int i = 0; i <= G; i++) {
        s.push_back(vector<vector<coek::Variable>>());
        for (int j = 0; j <= G; j++) {
            s[i].push_back(vector<coek::Variable>());
            for (int f = 0; f < F; f++) {
                s[i][j].push_back(
                    model.getVariable(0, COEK_INFINITY, 0)
                );
            }
        }
    }

    vector<vector<vector<vector<coek::Variable>>>> r;
    for (int i = 0; i <= G; i++) {
        r.push_back(vector<vector<vector<coek::Variable>>>());
        for (int j = 0; j <= G; j++) {
            r[i].push_back(vector<vector<coek::Variable>>());
            for (int f = 0; f < F; f++) {
                r[i][j].push_back(vector<coek::Variable>());
                for (int k = 0; k < 2; k++) {
                    r[i][j][f].push_back(
                        model.getVariable(-COEK_INFINITY, COEK_INFINITY, 0)
                        );
                }
            }
        }
    }

    // Add constraints

    // Each customer is assigned to a facility
    for (int i = 0; i <= G; i++) {
        for (int j = 0; j <= G; j++) {
            coek::Expression lhs;
            for (int f = 0; f < F; f++)
                lhs += z[i][j][f];
            model.add(lhs == 1);
        }
    }

    const double M = 2*sqrt(2.0);
    for (int i = 0; i <= G; i++) {
        for (int j = 0; j <= G; j++) {
            for (int f = 0; f < F; f++) {
                model.add(s[i][j][f] == d + M*(1 - z[i][j][f]));
                model.add(r[i][j][f][0] == (1.0*i)/G - y[f][0]);
                model.add(r[i][j][f][1] == (1.0*j)/G - y[f][1]);
                model.add(r[i][j][f][0]*r[i][j][f][0] + 
                                 r[i][j][f][1]*r[i][j][f][1] <= 
                                 s[i][j][f]*s[i][j][f]);
            }
        }
    }


    coek::Solver opt;
    opt.initialize("gurobi");
    opt.set_option("TimeLimit", 0);
    opt.solve(model);

    return 0;
}
