#!/bin/sh

echo "160 1"
(time -p ./pmedian  160 1) > testgurobi.160.out 2>&1
echo "320 1"
(time -p ./pmedian  320 1) > testgurobi.320.out 2>&1
echo "640 1"
(time -p ./pmedian  640 1) > testgurobi.640.out 2>&1
echo "1280 1"
(time -p ./pmedian 1280 1) > testgurobi.1280.out 2>&1


echo "size,gurobi" > gurobi.csv
for i in 160 320 640 1280
do
    tmp=`grep user "testgurobi.${i}.out" | awk '{print $2}'`
    if [ "$tmp" == "" ]; then
        tmp="0"
    fi;
    echo "$i,$tmp" >> gurobi.csv
done

