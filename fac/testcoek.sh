#!/bin/sh

echo "25"
time -p ./facility_coek  25 25 > testcoek.25.out 2>&1
echo "50"
time -p ./facility_coek  50 50 > testcoek.50.out 2>&1
echo "75"
time -p ./facility_coek  75 75 > testcoek.75.out 2>&1
echo "100"
time -p ./facility_coek 100 100 > testcoek.100.out 2>&1


echo "size,coek" > coek.csv
for i in 25 50 75 100
do
    tmp=`grep user "testcoek.${i}.out" | awk '{print $2}'`
    if [ "$tmp" == "" ]; then
        tmp="0"
    fi;
    echo "$i,$tmp" >> coek.csv
done

