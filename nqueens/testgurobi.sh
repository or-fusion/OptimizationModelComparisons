#!/bin/sh

source ../run_problem.sh

size=(160 320 640 1280)
name="gurobi"
command="./nqueens \$i 1"

run_problem $name "$command" ${size[@]}
