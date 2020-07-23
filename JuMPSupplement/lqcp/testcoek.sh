#!/bin/sh

source ../run_problem.sh

size=(500 1000 1500 2000)
name="coek"
command="./lqcp_${name} \$i"

run_problem $name "$command" ${size[@]}
