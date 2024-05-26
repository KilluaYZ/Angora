#! /bin/bash

if [ $# -ne 2 ] ; then
    echo "Usage: $0 <target program> <cmdline>"
    exit 1
fi

export AFL_NO_AFFINITY=1
export AFL_SKIP_CRASHES=1
export UBSAN_OPTIONS=print_stacktrace=1:halt_on_error=1

TARGET=$1
INPUT_PATH=/home/zy/benchmark/seed/$TARGET
OUTPUT_PATH=/home/zy/$1
TAINT_PROG=/home/zy/benchmark/bin/Angora/track/$1
FAST_PROG=/home/zy/benchmark/bin/Angora/fast/$1
ARGS=$2
echo TAINT_PROG=$TAINT_PROG
echo FAST_PROG=$FAST_PROG
/home/zy/Angora/angora_fuzzer -i $INPUT_PATH -o $OUTPUT_PATH -t $TAINT_PROG -- $FAST_PROG $ARGS
