#!/bin/sh

echo "80 1"
./pmedian  80 1 | ts -s "%.s"

echo "160 1"
./pmedian 160 1 | ts -s "%.s"

echo "320 1"
./pmedian 320 1 | ts -s "%.s"

echo "640 1"
./pmedian 640 1 | ts -s "%.s"
