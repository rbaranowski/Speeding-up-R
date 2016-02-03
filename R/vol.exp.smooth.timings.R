source("functions.R")


MC <- 256
M <- 4
n.list <- 256*c(1, 2, 4, 8, 16, 32, 64, 128)
lambda <- 0.05 

no.cores <- 8
require(parallel) #package for cluster computations

if(!is.loaded("vol_exp_smooth")) dyn.load("../lib/vol_exp_smooth.so")

cl <- makeCluster(no.cores)
clusterEvalQ(cl, if(!is.loaded("vol_exp_smooth")) dyn.load("../lib/vol_exp_smooth.so"))

res <- list()

for(j in 1:4) res[[j]] <- matrix(0, nrow=length(n.list), ncol=M)


for(i in 1:length(n.list)){

  n <- n.list[i]
  cat("n: ",n,"\n")
  
  for(j in 1:M){
    
    X <- matrix(rnorm(n*MC), n, MC)
    
    cat("j: ",j,"\n")  
    
    res[[1]][i,j] <- system.time(vol.exp.smooth.r(X = X, lambda = lambda))[3]
    res[[2]][i,j] <- system.time(vol.exp.smooth.rpcl(X = X, lambda = lambda, cl=cl))[3]
    res[[3]][i,j] <- system.time(vol.exp.smooth.rpc(X = X, lambda = lambda))[3]
    res[[4]][i,j] <- system.time(vol.exp.smooth.rpcpcl(X = X, lambda = lambda, cl=cl))[3]
    
    
  }  
}

stopCluster(cl)

for(j in 1:4) res[[j]] <- apply(res[[j]], 1, mean)

timings <- as.data.frame(matrix(unlist(res), ncol=4))
timings <- cbind(n=n.list, timings)
colnames(timings) <- c("n", "R", "R+cl", "R+C", "R+C+cl")

save(timings, file="vol_exp_smooth_timings.RData")
