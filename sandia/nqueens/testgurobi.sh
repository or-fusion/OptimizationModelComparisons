#!/bin/sh

source ../run_problem.sh

size=(400 600 800 1000)
name="gurobi"
command="./nqueens \$i 1"

run_problem $name "$command" ${size[@]}
