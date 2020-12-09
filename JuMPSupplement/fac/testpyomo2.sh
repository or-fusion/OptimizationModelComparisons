#!/bin/sh

if [ "$1" == "" ]; then
    suffix=""
else
    suffix="_$1"
fi

source ../run_problem.sh

size=(25 50 75 100)
name="pyomo2"

command="python ./facility_${name}.py \$i 1"
run_problem ${name}${suffix} "$command" ${size[@]}

command="pypy3 ./facility_${name}.py \$i 1"
run_problem ${name}${suffix}_pypy3 "$command" ${size[@]}
