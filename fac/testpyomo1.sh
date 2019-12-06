#!/bin/sh

if [ "$1" == "" ]; then
    suffix=""
else
    suffix="_$1"
fi

echo "25"
time -p python facility_pyomo.py  25 25 > testpyomo${suffix}.25.out 2>&1
echo "50"
time -p python facility_pyomo.py  50 50 > testpyomo${suffix}.50.out 2>&1
echo "75"
time -p python facility_pyomo.py  75 75 > testpyomo${suffix}.75.out 2>&1
echo "100"
time -p python facility_pyomo.py 100 100 > testpyomo${suffix}.100.out 2>&1


echo "size,pyomo1${suffix}" > pyomo${suffix}.csv
for i in 25 50 75 100
do
    tmp=`grep user "testpyomo1${suffix}.${i}.out" | awk '{print $2}'`
    if [ "$tmp" == "" ]; then
        tmp="0"
    fi;
    echo "$i,$tmp" >> pyomo1${suffix}.csv
done
