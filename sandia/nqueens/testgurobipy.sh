#!/bin/sh

source ../run_problem.sh

size=(400 600 800 1000)
name="gurobipy"
command="python ./nqueens_${name}.py \$i 1"

run_problem $name "$command" ${size[@]}
