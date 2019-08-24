#!/bin/sh

echo "25"
./facility_coek 25 25 | ts -s "%.s"

echo "50"
./facility_coek 50 50 | ts -s "%.s"

echo "75"
./facility_coek 75 75 | ts -s "%.s"

echo "100"
./facility_coek 100 100 | ts -s "%.s"
