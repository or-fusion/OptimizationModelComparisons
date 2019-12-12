#!/bin/sh

if [ "$1" == "" ]; then
    suffix=""
else
    suffix="_$1"
fi

source ../run_problem.sh

size=(5 50 500)
name="poek"
command="python ./clnlbeam_${name}.py \$i 1"

run_problem ${name}${suffix} "$command" ${size[@]}
