# Set minimum CMake version to version on Gadi:
cmake_minimum_required(VERSION 3.20.2)

project(
    integrate
    LANGUAGES Fortran
)

# third party libs
find_package(MPI REQUIRED)

add_executable(integrate_mpi integrate_mpi.F90)
target_link_libraries(integrate_mpi MPI::MPI_Fortran)
