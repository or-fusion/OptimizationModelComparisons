import pmedian_pyomo_linear
from pyomo.environ import SolverFactory

solver = SolverFactory("gurobi")
solver.solve(pmedian_pyomo_linear.model, options={"timelimit":0}, load_solutions=False, tee=True)
