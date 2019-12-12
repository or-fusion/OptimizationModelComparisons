#!/bin/sh

source ../run_problem.sh

size=(5 50 500)
name="coek"
command="./clnlbeam_${name} \$i 1"

run_problem $name "$command" ${size[@]}
