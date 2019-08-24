#!/bin/sh

echo "500"
./lqcp 500 | ts -s "%.s"

echo "1000"
./lqcp 1000 | ts -s "%.s"

echo "1500"
./lqcp 1500 | ts -s "%.s"

echo "2000"
./lqcp 2000 | ts -s "%.s"
