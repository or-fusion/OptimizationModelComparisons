#!/bin/sh

if [ "$1" == "" ]; then
    suffix=""
else
    suffix="_$1"
fi

source ../run_problem.sh

size=(500 1000 1500 2000)
name="pyomo1"
command="sh -c \"python ./lqcp_${name}.py \$i; gurobi_cl timelimit=0 pyomo.lp\""

run_problem ${name}${suffix} "$command" ${size[@]}
