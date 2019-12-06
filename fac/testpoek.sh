#!/bin/sh

if [ "$1" == "" ]; then
    suffix=""
else
    suffix="_$1"
fi

echo "25"
time -p python facility_poek.py  25 25 > testpoek${suffix}.25.out 2>&1
echo "50"
time -p python facility_poek.py  50 50 > testpoek${suffix}.50.out 2>&1
echo "75"
time -p python facility_poek.py  75 75 > testpoek${suffix}.75.out 2>&1
echo "100"
time -p python facility_poek.py 100 100 > testpoek${suffix}.100.out 2>&1


echo "size,poek${suffix}" > poek${suffix}.csv
for i in 25 50 75 100
do
    tmp=`grep user "testpoek${suffix}.${i}.out" | awk '{print $2}'`
    if [ "$tmp" == "" ]; then
        tmp="0"
    fi;
    echo "$i,$tmp" >> poek${suffix}.csv
done
