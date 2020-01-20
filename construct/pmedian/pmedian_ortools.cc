#include <iostream>
#include <vector>

#include "ortools/linear_solver/linear_solver.h"

namespace operations_research {
void pmedianOrTools(int N = 0, int M = 0, int P = 0) {
  // input parameters
  std::vector<std::vector<double>> d(N, std::vector<double>(M));
  for (int n = 0; n < N; n++)
    for (int m = 0; m < M; m++) d[n][m] = 1.0 + 1.0 / (n + m + 1);

  // init solver
  MPSolver solver("LinearExample", MPSolver::GLOP_LINEAR_PROGRAMMING);
  const double infinity = solver.infinity();

  // variables
  std::vector<std::vector<MPVariable *>> x;
  std::vector<MPVariable *> y;

  for (int n = 0; n < N; n++) {
    y[n] = solver.MakeNumVar(0.0, 1.0, "y");
    for (int m = 0; m < M; m++) x[n][m] = solver.MakeNumVar(0.0, 1.0, "x");
  }

  // objective
  MPObjective *const objective = solver.MutableObjective();
  for (int n = 0; n < N; n++)
    for (int m = 0; m < M; m++) objective->SetCoefficient(x[n][m], d[n][m]);
  objective->SetMinimization();

  // constraints
  // single_x
  MPConstraint *const single_x = solver.MakeRowConstraint(0.0, 1.0);
  for (int m = 0; m < M; m++)
    for (int n = 0; n < N; n++) single_x->SetCoefficient(x[n][m], 1.0);

  // bound_y
  MPConstraint *const bound_y = solver.MakeRowConstraint(-infinity, 0.0);
  for (int n = 0; n < N; n++)
    for (int m = 0; m < M; m++) {
      bound_y->SetCoefficient(x[n][m], 1.0);
      bound_y->SetCoefficient(y[n], -1.0);
    };

  // num_facilities
  MPConstraint *const num_facilities = solver.MakeRowConstraint(0.0, P);
  for (int n = 0; n < N; n++) num_facilities->SetCoefficient(y[n], 1.0);

  // Solve
  solver.set_time_limit(0);
  const MPSolver::ResultStatus result_status = solver.Solve();
}
}  // namespace operations_research

int main(int argc, char **argv) {
  int N = atoi(argv[1]);  // Locations
  int M = N;              // Customers
  int P = atoi(argv[2]);  // Facilities
  operations_research::pmedianOrTools(N, M, P);
  return EXIT_SUCCESS;
}