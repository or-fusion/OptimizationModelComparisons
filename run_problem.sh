#!/bin/bash

function run_problem ()
{
local name=$1
shift
local command=$1
shift
local size=("$@")

echo "size,${name}" > ${name}.csv
for i in "${size[@]}"
do
    echo "NAME $name  SIZE $i"
    time -p sh -c "${command//'$i'/$i}" > test${name}.${i}.out 2>&1

    tmp=`grep user "test${name}.${i}.out" | awk '{print $2}'`
    if [ "$tmp" == "" ]; then
        tmp="0"
    fi;
    echo "$i,$tmp" >> ${name}.csv
done
}
