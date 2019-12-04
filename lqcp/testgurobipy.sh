#!/bin/sh

echo "500"
(time -p python lqcp_gurobipy.py  500 ) > testgurobipy.500.out 2>&1
echo "1000"
(time -p python lqcp_gurobipy.py 1000 ) > testgurobipy.1000.out 2>&1
echo "1500"
(time -p python lqcp_gurobipy.py 1500 ) > testgurobipy.1500.out 2>&1
echo "2000"
(time -p python lqcp_gurobipy.py 2000 ) > testgurobipy.2000.out 2>&1


echo "size,gurobipy" > gurobipy.csv
for i in 500 1000 1500 2000
do
    tmp=`grep user "testgurobipy.${i}.out" | awk '{print $2}'`
    if [ "$tmp" == "" ]; then
        tmp="0"
    fi;
    echo "$i,$tmp" >> gurobipy.csv
done
