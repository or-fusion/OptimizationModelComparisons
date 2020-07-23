#!/bin/sh

source ../run_problem.sh

size=(25 50 75 100)
name="gurobi"
command="./facility \$i \$i"

run_problem $name "$command" ${size[@]}
