#!/bin/bash

source ../run_problem.sh

size=(50 100 500 1000)
name="pulp"
command="python3 ./knapsack_${name}.py \$i 1"

run_problem $name "$command" ${size[@]}
