#!/bin/sh

source ../run_problem.sh

size=(500 1000 1500 2000)
name="gurobi"
command="./lqcp \$i"

run_problem $name "$command" ${size[@]}
