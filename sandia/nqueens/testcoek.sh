#!/bin/sh

source ../run_problem.sh

size=(400 600 800 1000)
name="coek"
command="./nqueens_${name} \$i 1"

run_problem $name "$command" ${size[@]}
