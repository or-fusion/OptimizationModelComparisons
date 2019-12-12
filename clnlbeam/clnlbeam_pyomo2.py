import clnlbeam_pyomo
from pyomo.environ import SolverFactory

solver = SolverFactory("gurobi")
solver.solve(clnlbeam_pyomo.model.write, timelimit=0)
