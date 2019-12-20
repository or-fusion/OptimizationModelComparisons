#!/bin/sh

if [ "$1" == "" ]; then
    suffix=""
else
    suffix="_$1"
fi

source ../run_problem.sh

size=(160 320 640 1280)
name="pyomo2_linear"

command="python ./pmedian_${name}.py \$i 1"
run_problem ${name}${suffix} "$command" ${size[@]}

command="pypy3 ./pmedian_${name}.py \$i 1"
run_problem ${name}${suffix}_pypy3 "$command" ${size[@]}
