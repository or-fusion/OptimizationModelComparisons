#!/bin/sh

if [ "$1" == "" ]; then
    suffix=""
else
    suffix="_$1"
fi

source ../run_problem.sh

size=(400 600 800 1000)
name="pyomo2"

command="python ./nqueens_${name}.py \$i 1"
run_problem ${name}${suffix} "$command" ${size[@]}

command="pypy3 ./nqueens_${name}.py \$i 1"
run_problem ${name}${suffix}_pypy3 "$command" ${size[@]}
