#!/bin/sh

source ../run_problem.sh

size=(500 1000 1500 2000)
name="gurobipy"
command="python ./lqcp_${name}.py \$i"

run_problem $name "$command" ${size[@]}
