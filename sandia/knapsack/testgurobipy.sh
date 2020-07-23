#!/bin/sh

source ../run_problem.sh

size=(50 100 500 1000)
name="gurobipy"
command="python ./knapsack_${name}.py \$i"

run_problem $name "$command" ${size[@]}
