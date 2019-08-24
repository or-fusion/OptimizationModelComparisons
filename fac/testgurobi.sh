#!/bin/sh

echo "25"
./facility 25 25 | ts -s "%.s"

echo "50"
./facility 50 50 | ts -s "%.s"

echo "75"
./facility 75 75 | ts -s "%.s"

echo "100"
./facility 100 100 | ts -s "%.s"
