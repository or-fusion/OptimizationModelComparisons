import pmedian_pyomo
from pyomo.environ import SolverFactory

solver = SolverFactory("gurobi")
solver.solve(pmedian_pyomo.model, options={"timelimit":0}, load_solutions=False, tee=True)
