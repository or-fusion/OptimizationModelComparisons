#!/bin/sh

if [ "$1" == "" ]; then
    suffix=""
else
    suffix="_$1"
fi

source ../run_problem.sh

size=(160 320 640 1280)
name="pp"
command="python ./nqueens_${name}.py \$i 1"

run_problem ${name}${suffix} "$command" ${size[@]}
