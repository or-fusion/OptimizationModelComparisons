#!/bin/sh

source ../run_problem.sh

size=(50 100 500 1000)
name="coek"
command="./knapsack_${name} \$i"

run_problem $name "$command" ${size[@]}
