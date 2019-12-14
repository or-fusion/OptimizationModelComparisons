#!/bin/sh

if [ "$1" == "" ]; then
    suffix=""
else
    suffix="_$1"
fi

source ../run_problem.sh

size=(5 50 500)
name="pyomo2"

command="python ./clnlbeam_${name}.py \$i"
run_problem ${name}${suffix} "$command" ${size[@]}

command="pypy3 ./clnlbeam_${name}.py \$i"
run_problem ${name}${suffix}_pypy3 "$command" ${size[@]}
