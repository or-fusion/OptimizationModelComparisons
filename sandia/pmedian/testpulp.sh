#!/bin/bash

source ../run_problem.sh

size=(160 320 640 1280)
name="pulp"
command="python3 ./pmedian_${name}.py \$i 1"

run_problem $name "$command" ${size[@]}
