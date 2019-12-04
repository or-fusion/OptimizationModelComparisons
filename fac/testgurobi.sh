#!/bin/sh

echo "25"
(time -p ./facility  25 25) > testgurobi.25.out 2>&1
echo "50"
(time -p ./facility  50 50) > testgurobi.50.out 2>&1
echo "75"
(time -p ./facility  75 75) > testgurobi.75.out 2>&1
echo "100"
(time -p ./facility 100 100) > testgurobi.100.out 2>&1


echo "size,gurobi" > gurobi.csv
for i in 25 50 75 100
do
    tmp=`grep user "testgurobi.${i}.out" | awk '{print $2}'`
    if [ "$tmp" == "" ]; then
        tmp="0"
    fi;
    echo "$i,$tmp" >> gurobi.csv
done

