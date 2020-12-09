# OptimizationModelComparisons

This repository enables performance comparisons between optimization
modeling environments.  Although runtime performance is often a
consideration for optimization solvers, scalable modeling environments
are often needed for large-scale applications.  This repository includes
modeling formulations for a variety of optimization applications, using
the following modeling environments:

- AMPL
- **_COEK_**  (a C++ modeling environment similar to Gurobi's)  (see https://github.com/or-fusion/coek)
- GAMS
- **_Gurobi C++_**
- **_Gurobi Python_**
- JuMP
- or-tools Python (see https://github.com/google/or-tools)
- or-tools C++ (to appear)
- **_POEK_** (a Python interface to COEK)  (see https://github.com/or-fusion/poek)
- PuLP
- **_Pyomo_** (see https://github.com/Pyomo/pyomo)
- YALMIP

Notes:
* For specific applications, not all modeling environments may be included,
though this is a long-term goal for this effort.
* Every effort has been made to make these best-case exemplars for each modeling environment, and we encourage contributions where models can be improved.

The optimization applications are organized into the following
sub-directories:

* JuMPSupplement
  * These applications were included as supplementary materials and code for
"JuMP: A Modeling Language for Mathematical Optimization" by I. Dunning,
J. Huchette, and M. Lubin.  See [the old README for details](JuMPSupplement/README.md).
  * Note that changes have been made to some of these examples to ensure consistency between the modeling formulations, or to provide better exemplars for given modeling environments.

* sandia
  * These applications are used by Sandia's optimization researchers to 
    evaluate the scalability of modeling environments.

* cute
  * These large CUTE models illustrate scalability challenges for modeling environments.



# Performance Testing

## Overview

This repository includes several categories of performance tests:

- construct:  Tests that construct a model and call a solver to
setup the solver data structures

- solve:  Tests that construct and solve a model, which tests the time
needed to process solver output

- resolve:  Tests that iteratively resolve a problem whose parameters
change

Note that the testing methodology used here differs somewhat from the 
approach used in the JuMP paper.
The testing scripts measure the user time, which is not influenced
by other processes running on the testing computer.  Additionally,
the *construct* tests measure the total time to complete a calculation,
which includes truncated solver executions.  For example, we include the
time to execute Gurobi using a timelimit of zero seconds for Gurobi's
solver.  These changes allow the performance tests to be automated in
a reliable manner, but they do not change the gross performance
characteristics observed in previous experimental comparisons.


### Construct Results

The following results determine the runtimes for the creation in the different modeling tools and languages for specific problems.

#### pmedian

Runtime Performance (seconds)

| Modeling   |   160 | 320     | 640     | 1280    |
|------------|-------|---------|---------|---------|
| coek       |  0.12 | 0.52    | 2.26    | 9.25    |
| gurobi     |  0.11 | 0.44    | 1.82    | 7.47    |
| gurobipy   |  0.51 | 2.09    | 12.37   | 44.23   |
| ortoolspy  |  0.65 | 2.85    | 12.84   | 55.12   |
| pulp       |  2.15 | 8.4     | 38.76   | 161.57  |
| poek       |  1.3  | 3.94    | timeout | timeout |
| pp         |  3.98 | timeout | timeout | timeout |
| pyomo1     |  3.54 | timeout | timeout | timeout |


#### knapsack

#### nqueens


## Replicating Tests

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

### Summarizing Tests

The `summarize.py` script can be used to generate tabular summaries of the performance
tests for a specific problem. For example, if tests have been run for the `pmedian` test problem, then the command
```
python summarize.py pmedian
```
will process the CSV files in the `pmedian` directory and summarize their results and output the result table to terminal.

