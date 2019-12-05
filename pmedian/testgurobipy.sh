#!/bin/sh

echo "160 1"
time -p python pmedian_gurobipy.py  160 1 > testgurobipy.160.out 2>&1
echo "320 1"
time -p python pmedian_gurobipy.py  320 1 > testgurobipy.320.out 2>&1
echo "640 1"
time -p python pmedian_gurobipy.py  640 1 > testgurobipy.640.out 2>&1
echo "1280 1"
time -p python pmedian_gurobipy.py 1280 1 > testgurobipy.1280.out 2>&1


echo "size,gurobipy" > gurobipy.csv
for i in 160 320 640 1280
do
    tmp=`grep user "testgurobipy.${i}.out" | awk '{print $2}'`
    if [ "$tmp" == "" ]; then
        tmp="0"
    fi;
    echo "$i,$tmp" >> gurobipy.csv
done
