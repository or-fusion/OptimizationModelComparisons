#!/bin/sh

source ../run_problem.sh

size=(50000 100000 500000 1000000)
name="gurobi"
command="./knapsack \$i"

run_problem $name "$command" ${size[@]}
