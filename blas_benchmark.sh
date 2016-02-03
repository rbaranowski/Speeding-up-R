#!/bin/bash
#This script runs the matrix multiplication example for different choices of BLAS library. User should modify the paths where appropriate.
LD_PRELOAD=/usr/lib/libblas/libblas.so Rscript R/matrix.product.R
Rscript R/matrix.product.R
LD_PRELOAD="/usr/local/cuda/lib64/libnvblas.so" Rscript R/matrix.product.R
