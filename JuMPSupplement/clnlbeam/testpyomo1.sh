#!/bin/sh

if [ "$1" == "" ]; then
    suffix=""
else
    suffix="_$1"
fi

source ../run_problem.sh

size=(5 50 500)
name="pyomo1"
command="sh -c \"python ./clnlbeam_${name}.py \$i; ipopt timelimit=0 pyomo.nl\""

run_problem ${name}${suffix} "$command" ${size[@]}
