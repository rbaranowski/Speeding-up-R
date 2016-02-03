### This script illustrates a few ways to speed R code using code profiling, parallel computations and C.
### For details, see the presentaion.
source("functions.R") ## we source functions for volatility estimation
n <- 2000 #length of each vector
lambda <- 0.05 #parameter for the exponential smoother
MC <- 10000 #numver of Monte-Carlo repetitions
X <- matrix(rnorm(n*MC), n, MC) #matrix with the data


#### We check what's the performence of the vol.exp.smooth.r, which uses only R code
system.time(vol <- vol.exp.smooth.r(X = X, lambda = lambda))



#### Now we run the same code on multiple cores
require(parallel) #package for cluster computations
no.cores <- 8 #number of availavle cores, typically 4 or 8

## We initiate the cluster
cl <- makeCluster(no.cores) 
system.time(vol <- vol.exp.smooth.rpcl(X, lambda, cl))


#### This example illustrates how to use Rprof function
Rprof() #start profiling
vol <- vol.exp.smooth.r(X = X, lambda = lambda)
Rprof(NULL) #stop profiling
summaryRprof()

#### Running R extensions written in C
if(!is.loaded("vol_exp_smooth")) dyn.load("../lib/vol_exp_smooth.so") ## we need to make sure that our library is loaded
system.time(vol <- vol.exp.smooth.rpc(X = X, lambda = lambda))


#### It is a good practice to clean-up and close all instances of R once we are done with everything.
stopCluster(cl)




