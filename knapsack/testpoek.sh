#!/bin/sh

if [ "$1" == "" ]; then
    suffix=""
else
    suffix="_$1"
fi

source ../run_problem.sh

size=(50000 100000 500000 1000000)
name="poek"
command="python ./knapsack_${name}.py \$i"

run_problem ${name}${suffix} "$command" ${size[@]}
