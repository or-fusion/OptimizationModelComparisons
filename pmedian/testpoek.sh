#!/bin/sh

if [ "$1" == "" ]; then
    suffix=""
else
    suffix="_$1"
fi

echo "160 1"
time -p python pmedian_poek.py  160 1 > testpoek${suffix}.160.out 2>&1
echo "320 1"
time -p python pmedian_poek.py  320 1 > testpoek${suffix}.320.out 2>&1
echo "640 1"
time -p python pmedian_poek.py  640 1 > testpoek${suffix}.640.out 2>&1
echo "1280 1"
time -p python pmedian_poek.py 1280 1 > testpoek${suffix}.1280.out 2>&1


echo "size,poek${suffix}" > poek${suffix}.csv
for i in 160 320 640 1280
do
    tmp=`grep user "testpoek${suffix}.${i}.out" | awk '{print $2}'`
    if [ "$tmp" == "" ]; then
        tmp="0"
    fi;
    echo "$i,$tmp" >> poek${suffix}.csv
done
