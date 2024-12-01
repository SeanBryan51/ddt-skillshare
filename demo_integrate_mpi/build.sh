#!/bin/bash
module purge
# This does work:
#module load intel-compiler/2019.5.281 intel-mpi/2019.5.281
# This does not work:
module load intel-compiler/2019.5.281 openmpi/4.1.4
rm -rf build
cmake -S . -B build
cmake --build build -v
