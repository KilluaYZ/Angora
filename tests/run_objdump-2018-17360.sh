#!/bin/bash
rm -r objdump-2.31.1-2018-17360
./run_fuzz.sh objdump-2.31.1-2018-17360 "--dwarf-check -C -g -f -dwarf -x @@"