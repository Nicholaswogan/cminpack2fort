# cminpack2fort

`cminpack2fort` is a fortran wrapper to [cminpack](https://github.com/devernay/cminpack), which is for optimization, and solving systems of non-linear equations.

[Minpack](https://www.netlib.org/minpack/) was originally written in fortran. [cminpack](https://github.com/devernay/cminpack) is a C rewrite of the original code. However, cminpack allows you to pass data to your objective function in a thread-safe manner, via a pointer. The original minpack can not be used in a thread-safe manner. `cminpack2fort` is a simple fortran interface to some of the routines in cminpack.

You need CMake, a C compiler, and a Fortran compiler. Then you can build with

```sh
mkdir build
cd build
cmake ..
make
```
