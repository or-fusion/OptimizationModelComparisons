#!/bin/sh

echo "160 1"
time -p python pmedian_pp.py  160 1 > testpp.160.out 2>&1
echo "320 1"
time -p python pmedian_pp.py  320 1 > testpp.320.out 2>&1
echo "640 1"
time -p python pmedian_pp.py  640 1 > testpp.640.out 2>&1
echo "1280 1"
time -p python pmedian_pp.py 1280 1 > testpp.1280.out 2>&1


echo "size,pp" > pp.csv
for i in 160 320 640 1280
do
    tmp=`grep user "testpp.${i}.out" | awk '{print $2}'`
    if [ "$tmp" == "" ]; then
        tmp="0"
    fi;
    echo "$i,$tmp" >> pp.csv
done
