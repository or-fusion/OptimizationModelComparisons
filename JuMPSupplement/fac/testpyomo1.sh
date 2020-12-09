#!/bin/sh

if [ "$1" == "" ]; then
    suffix=""
else
    suffix="_$1"
fi

source ../run_problem.sh

size=(25 50 75 100)
name="pyomo1"
command="sh -c \"python ./facility_${name}.py \$i \$i; gurobi_cl timelimit=0 pyomo.lp\""

run_problem ${name}${suffix} "$command" ${size[@]}
