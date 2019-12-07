#!/bin/sh

source ../run_problem.sh

size=(50000 100000 500000 1000000)
name="gurobipy"
command="python ./knapsack_${name}.py \$i"

run_problem $name "$command" ${size[@]}
