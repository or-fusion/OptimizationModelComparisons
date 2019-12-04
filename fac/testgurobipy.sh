#!/bin/sh

echo "25"
(time -p python facility_gurobipy.py  25 25 ) > testgurobipy.25.out 2>&1
echo "50"
(time -p python facility_gurobipy.py  50 50 ) > testgurobipy.50.out 2>&1
echo "75"
(time -p python facility_gurobipy.py  75 75 ) > testgurobipy.75.out 2>&1
echo "100"
(time -p python facility_gurobipy.py 100 100 ) > testgurobipy.100.out 2>&1


echo "size,gurobipy" > gurobipy.csv
for i in 25 50 75 100
do
    tmp=`grep user "testgurobipy.${i}.out" | awk '{print $2}'`
    if [ "$tmp" == "" ]; then
        tmp="0"
    fi;
    echo "$i,$tmp" >> gurobipy.csv
done
