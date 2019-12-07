#!/bin/sh

source ../run_problem.sh

size=(25 50 75 100)
name="coek"
command="./facility_${name} \$i \$i"

run_problem $name "$command" ${size[@]}
