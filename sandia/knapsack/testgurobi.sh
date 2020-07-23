#!/bin/sh

source ../run_problem.sh

size=(50 100 500 1000)
name="gurobi"
command="./knapsack \$i"

run_problem $name "$command" ${size[@]}
