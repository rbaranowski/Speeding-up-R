#!/bin/bash

cd src
R CMD SHLIB vol_exp_smooth.c  -fopenmp
rm *.o
mv *.so ../lib
