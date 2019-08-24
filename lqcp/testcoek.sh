#!/bin/sh

echo "500"
./lqcp_coek 500 | ts -s "%.s"

echo "1000"
./lqcp_coek 1000 | ts -s "%.s"

echo "1500"
./lqcp_coek 1500 | ts -s "%.s"

echo "2000"
./lqcp_coek 2000 | ts -s "%.s"
