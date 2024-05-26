#! /bin/bash

if [ $# -ne 2 ] ; then
    echo "Usage: $0 <target program> <cmdline>"
    exit 1
fi

TARGET=$1
INPUT_PATH=./benchmark/seed/$TARGET
OUTPUT_PATH=./$1
TAINT_PROG=./benchmark/bin/Angora/track/$1
FAST_PROG=./benchmark/bin/Angora/fast/$1
ARGS=$2
echo TAINT_PROG=$TAINT_PROG
echo FAST_PROG=$FAST_PROG
/home/zy/Angora/angora_fuzzer -i $INPUT_PATH -o $OUTPUT_PATH -t $TAINT_PROG -- $FAST_PROG $ARGS
