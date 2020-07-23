#!/bin/sh

if [ "$1" == "" ]; then
    suffix=""
else
    suffix="_$1"
fi

source ../run_problem.sh

size=(500 1000 1500 2000)
name="pp"
command="python ./lqcp_${name}.py \$i"

run_problem ${name}${suffix} "$command" ${size[@]}
