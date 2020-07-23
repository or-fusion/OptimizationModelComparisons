#!/bin/sh

if [ "$1" == "" ]; then
    suffix=""
else
    suffix="_$1"
fi

source ../run_problem.sh

size=(25 50 75 100)
name="poek"
command="python ./facility_${name}.py \$i \$i"

run_problem ${name}${suffix} "$command" ${size[@]}
