#!/bin/sh

echo "500"
(time -p ./lqcp  500) > testgurobi.500.out 2>&1
echo "1000"
(time -p ./lqcp 1000) > testgurobi.1000.out 2>&1
echo "1500"
(time -p ./lqcp 1500) > testgurobi.1500.out 2>&1
echo "2000"
(time -p ./lqcp 2000) > testgurobi.2000.out 2>&1


echo "size,gurobi" > gurobi.csv
for i in 500 1000 1500 2000
do
    tmp=`grep user "testgurobi.${i}.out" | awk '{print $2}'`
    if [ "$tmp" == "" ]; then
        tmp="0"
    fi;
    echo "$i,$tmp" >> gurobi.csv
done

