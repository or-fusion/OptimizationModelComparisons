#!/bin/sh

echo "160 1"
time ./pmedian  160 1

echo "320 1"
time ./pmedian  320 1

echo "640 1"
time ./pmedian  640 1

echo "1280 1"
time ./pmedian 1280 1
