cmake_minimum_required (VERSION 3.0.0)

project(cminpack2fort LANGUAGES Fortran C)

if (NOT DEFINED CMAKE_BUILD_TYPE)
  set (CMAKE_BUILD_TYPE Release CACHE STRING "Build type")
endif ()

option(USE_BLAS OFF)
set(CMINPACK_PRECISION "d" CACHE STRING "Needs to be double precision")
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/cminpack-1.3.8)

add_library(cminpack2fort 
            ${CMAKE_CURRENT_SOURCE_DIR}/cminpack_wrapper.c 
            ${CMAKE_CURRENT_SOURCE_DIR}/cminpack_wrapper.f90)
          
target_link_libraries(cminpack2fort)
target_include_directories(cminpack2fort PUBLIC
                          ${CMAKE_CURRENT_SOURCE_DIR}/cminpack-1.3.8
                          )

add_executable(test_wrapper ${CMAKE_CURRENT_SOURCE_DIR}/test_wrapper.f90)
target_link_libraries(test_wrapper PUBLIC cminpack cminpack2fort )
