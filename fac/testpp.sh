#!/bin/sh

if [ "$1" == "" ]; then
    suffix=""
else
    suffix="_$1"
fi

echo "25"
time -p python facility_pp.py  25 25 > testpp${suffix}.25.out 2>&1
echo "50"
time -p python facility_pp.py  50 50 > testpp${suffix}.50.out 2>&1
echo "75"
time -p python facility_pp.py  75 75 > testpp${suffix}.75.out 2>&1
echo "100"
time -p python facility_pp.py 100 100 > testpp${suffix}.100.out 2>&1


echo "size,pp${suffix}" > pp${suffix}.csv
for i in 25 50 75 100
do
    tmp=`grep user "testpp${suffix}.${i}.out" | awk '{print $2}'`
    if [ "$tmp" == "" ]; then
        tmp="0"
    fi;
    echo "$i,$tmp" >> pp${suffix}.csv
done
