# OptimizationModelComparisons

This repository used to contain supplementary materials and code for
"JuMP: A Modeling Language for Mathematical Optimization" by I. Dunning,
J. Huchette, and M. Lubin.  See [the old README for details](README_OLD.md).

The repository has been generalized to include comparisons with other
modeling environments, and to include new test problems.  The general
focus of this repository is on enabling performance comparisons, rather
than critiquing modeling capabilities.  However, these test problems
do provide a point of reference for different optimization modeling
environments.  Specifically, this repository currently includes examples for the following modeling environments:
- *Gurobi C++*
- *Gurobi Python*
- *COEK (a C++ modeling environment similar to Gurobi's)*   (see https://gitlab.com/coopr/coek)
- *POEK (a Python interface to COEK)*  (see https://gitlab.com/coopr/poek)
- *Pyomo*  (see https://github.com/Pyomo/pyomo)
- JuMP
- GAMS
- AMPL
- YALMIP
Note that the modeling environments highlighted here have mature testing scripts.

# Performance Testing

## Overview

This repository generalizes the previous tests to include several different test categories:
- construct:  Tests that construct a model and call a solver to preliminary setup of the solver data structures
- solve:  Tests that construct and solve a model, which tests the time needed to process solver output
- resolve:  Tests that iteratively resolve a problem whose parameters change

One important deviation from the original repository concerns the
timing methodology.  The data reported in the JuMP paper used the ``ts``
command-line utility, which measures the wallclock time and annotates
the output.  The timing experiments reported in the JuMP paper measured the time to complete the solver setup.

The revised testing scripts measure the user time, which is not influenced by other processes running on the testing computer.  Additionally, the testing scripts measure the total time to complete a calculation, which includes truncated solver executions.  For example, we include the time to execute Gurobi using a timelimit of zero seconds for Gurobi's solver.  These changes allow the performance tests to be automated in a more reliable manner, but they do not change the gross performance characteristics observed in previous experiments.

The following test problems have mature performance testing scripts:
- pmedian: A p-median facility location problem
- knapsack: A binary knapsack problem
- lqcp: A linear quadratic control problem
- facility: A quadratic facility location problem

## Running Tests

Each test problem directory contains a number of BASH scripts that can
be used to execute performance tests.  By default, these scripts require
no options.  For example, to compile and run the gurobi executable,
you would do the following:
```
make
cd pmedian
./testgurobi.sh
```
This creates a summary file, `gurobi.csv`, which shows the runtime for the Gurobi on this test problem for different problem sizes.  The file also indicates a status:
- ok:  The test ran normally
- error: The test ended with an error
- timelimit: The test ended because it ran out of time.

By default, tests run for 600 seconds (10 minutes) before they are
terminated.  The user can set the `TEST_TIMEOUT` environmental variable to
an integer value specifying the number of seconds used by the `timeout`
command.

The BASH scripts that test python modeling environments accept an optimal
argument that can be used to provide some context for the testing results.
For example, if Python 3.7 is being used to test Pyomo, then the use
might type:
```
./testpyomo1.sh py37
```
This creates the summary file `pyomo1_py37.csv`, and this tag is included
in the file to allow comparison for different tests.

## Summarizing Tests

The `summarize.py` script can be used to generate tabular summaries of the performance
tests for a specific problem. For example, if tests have been run for the `pmedian` test problem, then the command
```
python summarize.py pmedian
```
will process the CSV files in the `pmedian` directory and summarize their results.  For example:
```
Data Summary: pmedian

Runtime Performance (seconds)
+------------+-------+---------+---------+---------+
| Modeling   |   160 | 320     | 640     | 1280    |
|------------+-------+---------+---------+---------|
| coek       |  0.12 | 0.52    | 2.26    | 9.25    |
| gurobi     |  0.11 | 0.44    | 1.82    | 7.47    |
| gurobipy   |  0.51 | 2.09    | 12.37   | 44.23   |
| pulp       |  2.15 | 8.4     | 38.76   | 161.57  |
| poek       |  1.3  | 3.94    | timeout | timeout |
| pp         |  3.98 | timeout | timeout | timeout |
| pyomo1     |  3.54 | timeout | timeout | timeout |
+------------+-------+---------+---------+---------+

Normalized Performance (relative to Gurobi)
+------------+-------+---------+---------+---------+
| Modeling   |   160 | 320     | 640     | 1280    |
|------------+-------+---------+---------+---------|
| coek       |  1.09 | 1.18    | 1.24    | 1.24    |
| gurobi     |  1    | 1.0     | 1.0     | 1.0     |
| gurobipy   |  7.45 | 7.45    | timeout | timeout |
| poek       | 11.82 | 8.95    | timeout | timeout |
| pp         | 36.18 | timeout | timeout | timeout |
| pyomo1     | 32.18 | timeout | timeout | timeout |
+------------+-------+---------+---------+---------+
```

# Installation

This section needs to be updated.

The `Makefile` supports the compilation of all executables within this repository.


## OLD Instructions

The performance benchmarks depend on the following commercial software packages, which must be installed separately:
- AMPL (20160207)
- GAMS (24.6.1)
- Gurobi (6.5.0)
- MATLAB (R2015b)

Additionally, users should install:
- [YALMIP](http://users.isy.liu.se/johanl/yalmip/pmwiki.php?n=Tutorials.Installation) (20150918)
- [Pyomo](https://software.sandia.gov/downloads/pub/pyomo/PyomoInstallGuide.html) 
- [Julia](http://julialang.org/downloads/) (0.4.3)


*Installation instructions for Pyomo:*

A simple way to install Pyomo is through the ``virtualenv`` package:
```
$ virtualenv venv
$ source venv/bin/activate
$ pip install pyomo

(venv)$ pyomo --version
Pyomo 4.2.10784 (CPython 2.7.11 on Linux 4.4.1-2-ARCH)
```

*Installation instructions for Julia:*

We recommend reproducing the experiments with the exact version of Julia used here. If binaries for version 0.4.3 are no longer available, one can build Julia from source as follows:
```
$ git clone git://github.com/JuliaLang/julia.git
$ cd julia
$ git checkout v0.4.3
$ make
```

Unfortunately, the build process relies on many external packages and URLs. It cannot be expected to work indefinitely, even if github.com remains available.

Once Julia is installed, we require the following Julia packages:
- [JuMP](https://github.com/JuliaOpt/JuMP.jl) 0.12.0
- [ReverseDiffSparse](https://github.com/mlubin/ReverseDiffSparse.jl) 0.5.3
- [Gurobi.jl](https://github.com/JuliaOpt/Gurobi.jl) 0.2.1
- [Ipopt.jl](https://github.com/JuliaOpt/Ipopt.jl) 0.2.1

You should force the use of particular versions of these Julia packages with
```
julia> Pkg.pin("JuMP", v"0.12.0")
julia> Pkg.pin("ReverseDiffSparse", v"0.5.3")
julia> Pkg.pin("Gurobi", v"0.2.1")
julia> Pkg.pin("Ipopt", v"0.2.1")
```

For the nonlinear tests, you should add ``ipopt`` compiled with ASL to your path.
On Linux, you can just use the Ipopt binary from Julia:

```
export PATH=$PATH:$HOME/.julia/v0.4/Ipopt/deps/usr/bin
```

# Change Log

- Feburary 2016: Update for first paper revision. Newer versions of all packages.
- April 2015: Initial version
