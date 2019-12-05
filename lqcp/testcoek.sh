#!/bin/sh

echo "500"
(time -p ./lqcp_coek  500) > testcoek.500.out 2>&1
echo "1000"
(time -p ./lqcp_coek 1000) > testcoek.1000.out 2>&1
echo "1500"
(time -p ./lqcp_coek 1500) > testcoek.1500.out 2>&1
echo "2000"
(time -p ./lqcp_coek 2000) > testcoek.2000.out 2>&1


echo "size,coek" > coek.csv
for i in 500 1000 1500 2000
do
    tmp=`grep user "testcoek.${i}.out" | awk '{print $2}'`
    if [ "$tmp" == "" ]; then
        tmp="0"
    fi;
    echo "$i,$tmp" >> coek.csv
done

