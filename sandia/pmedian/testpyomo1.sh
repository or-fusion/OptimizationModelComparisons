#!/bin/sh

if [ "$1" == "" ]; then
    suffix=""
else
    suffix="_$1"
fi

source ../run_problem.sh

size=(160 320 640 1280)
name="pyomo1"
command="sh -c \"python ./pmedian_${name}.py \$i 1; gurobi_cl timelimit=0 pyomo.lp\""

run_problem ${name}${suffix} "$command" ${size[@]}
