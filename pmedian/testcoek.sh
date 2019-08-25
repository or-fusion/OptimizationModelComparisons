#!/bin/sh

echo "160 1"
./pmedian_coek  160 1 | ts -s "%.s"

echo "320 1"
./pmedian_coek  320 1 | ts -s "%.s"

echo "640 1"
./pmedian_coek  640 1 | ts -s "%.s"

echo "1280 1"
./pmedian_coek 1280 1 | ts -s "%.s"
