#!/bin/bash

#
# NOTE: We want to run final tests with a timeout value of 10m
# but for development purposes we may use a shorter limit.
#
if [ "$TEST_TIMEOUT" == "" ]; then
    timelimit="10m"
else
    timelimit="${TEST_TIMEOUT}s"
fi

trap '{ echo "You pressed Ctrl-C.  Time to quit." ; exit 1; }' INT
function run_problem ()
{
local name=$1
shift
local command=$1
shift
local size=("$@")

echo "size,${name},status" > ${name}.csv
for i in "${size[@]}"
do
    echo "NAME $name  SIZE $i"
    timeout $timelimit time -p sh -c "${command//'$i'/$i}" > test${name}.${i}.out 2>&1
    retval=$?

    status="ok"
    if [ "$retval" -eq "124" ]; then
        status="timeout"
    elif [ "$retval" -ne "0" ]; then
        status="error"
    fi
    echo "Status: ${status} ($retval)"

    tmp=`grep user "test${name}.${i}.out" | awk '{print $2}'`
    if [ "$tmp" == "" ]; then
        tmp="0"
    fi;
    echo "$i,$tmp,$status" >> ${name}.csv
done
}
