#!/bin/sh

echo "160 1"
time -p sh -c 'python pmedian_pyomo.py  160 1; gurobi_cl timelimit=0 pyomo.lp' > testpyomo1.160.out 2>&1
echo "320 1"
time -p sh -c 'python pmedian_pyomo.py  320 1; gurobi_cl timelimit=0 pyomo.lp' > testpyomo1.320.out 2>&1
echo "640 1"
time -p sh -c 'python pmedian_pyomo.py  640 1; gurobi_cl timelimit=0 pyomo.lp' > testpyomo1.640.out 2>&1
echo "1280 1"
time -p sh -c 'python pmedian_pyomo.py 1280 1; gurobi_cl timelimit=0 pyomo.lp' > testpyomo1.1280.out 2>&1


echo "size,pyomo1" > pyomo1.csv
for i in 160 320 640 1280
do
    tmp=`grep user "testpyomo1.${i}.out" | awk '{print $2}'`
    if [ "$tmp" == "" ]; then
        tmp="0"
    fi;
    echo "$i,$tmp" >> pyomo1.csv
done
