#!/bin/sh

echo "160 1"
(time -p ./pmedian_coek  160 1) > testcoek.160.out 2>&1
echo "320 1"
(time -p ./pmedian_coek  320 1) > testcoek.320.out 2>&1
echo "640 1"
(time -p ./pmedian_coek  640 1) > testcoek.640.out 2>&1
echo "1280 1"
(time -p ./pmedian_coek 1280 1) > testcoek.1280.out 2>&1


echo "size,coek" > coek.csv
for i in 160 320 640 1280
do
    tmp=`grep user "testcoek.${i}.out" | awk '{print $2}'`
    if [ "$tmp" == "" ]; then
        tmp="0"
    fi;
    echo "$i,$tmp" >> coek.csv
done

