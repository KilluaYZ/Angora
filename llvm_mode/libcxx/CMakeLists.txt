# run compile.sh

add_custom_command(
    OUTPUT afl-llvm-rt.o 
    COMMAND clang -fPIC -c afl-llvm-rt.o.c -o afl-llvm-rt.o 
    DEPENDS afl-llvm-rt.o.c
)

add_custom_command(
    OUTPUT afl-llvm-rt-64.o 
    COMMAND clang -fPIC -m64 -c afl-llvm-rt.o.c -o afl-llvm-rt-64.o 
    DEPENDS afl-llvm-rt.o.c
)

install (FILES "build_fast/lib/libc++.a" DESTINATION "${ANGORA_LIB_DIR}/libcxx_fast" RENAME "libc++fast.a")
install (FILES "build_fast/lib/libc++abi.a" DESTINATION "${ANGORA_LIB_DIR}/libcxx_fast" RENAME "libc++abifast.a")
install (FILES "build_track/lib/libc++.a" DESTINATION "${ANGORA_LIB_DIR}/libcxx_track" RENAME "libc++track.a")
install (FILES "build_track/lib/libc++abi.a" DESTINATION "${ANGORA_LIB_DIR}/libcxx_track" RENAME "libc++abitrack.a")


# add_library(afl-llvm-rt-64 OBJECT afl-llvm-rt.o.c)
# target_compile_options(afl-llvm-rt-64 PRIVATE -fPIC -m64)

# add_library(afl-llvm-rt OBJECT afl-llvm-rt.o.c)
# target_compile_options(afl-llvm-rt PRIVATE -fPIC)

install (FILES "afl-llvm-rt.o" DESTINATION "${ANGORA_LIB_DIR}")
install (FILES "afl-llvm-rt-64.o" DESTINATION "${ANGORA_LIB_DIR}")
