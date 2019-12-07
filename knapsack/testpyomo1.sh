#!/bin/sh

if [ "$1" == "" ]; then
    suffix=""
else
    suffix="_$1"
fi

source ../run_problem.sh

size=(50000 100000 500000 1000000)
name="pyomo1"
command="sh -c \"python ./knapsack_${name}.py \$i; gurobi_cl timelimit=0 pyomo.lp\""

run_problem ${name}${suffix} "$command" ${size[@]}
