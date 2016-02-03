# Meaning of the parameters in the functions below
# X: a n by MC matrix with thata
# lambda: a scalar in (0,1)
# cl: a cluster created with makeCluster function


#Function estimates the volatility using Exponentially Weighted Exponential Average - R only version

vol.exp.smooth.r <- function(X, lambda, ...){

  apply(X, 2, function(x){
    
    n <- length(x)
    
    vol <- rep(0, n)
    vol[1] <- x[1]^2
    
    for(j in 2:n) vol[j] <-  lambda * x[j]^2 + (1-lambda) * vol[j-1]
    
    return(vol)
    
  })

  
}

#Function estimates the volatility using Exponentially Weighted Exponential Average - R parallel only version

vol.exp.smooth.rpcl <- function(X, lambda, cl, ...){
  
  clusterExport(cl, list("lambda"))
  
  parApply(cl, X, 2, function(x){
    
    n <- length(x)
    
    vol <- rep(0, n)
    vol[1] <- x[1]^2
    
    for(j in 2:n) vol[j] <-  lambda * x[j]^2 + (1-lambda) * vol[j-1]
    
    return(vol)
  })
  
  
}

#Function estimates the volatility using Exponentially Weighted Exponential Average - C version

vol.exp.smooth.rpc <- function(X, lambda, ...){
  
  apply(X, 2, function(x){
    
    res <- .C("vol_exp_smooth", as.double(x), as.integer(length(x)), as.double(lambda), as.double(rep(0,length(x))))
    vol <- res[[4]]
    
    return(vol)
    
  })

}

#Function estimates the volatility using Exponentially Weighted Exponential Average - C + parallel version

vol.exp.smooth.rpcpcl <- function(X, lambda, cl=cl, ...){

  
  parApply(cl, X, 2, function(x, lambda){
    
    res <- .C("vol_exp_smooth", as.double(x), as.integer(length(x)), as.double(lambda), as.double(rep(0,length(x))))
    vol <- res[[4]]
    
    return(vol)
    
  }, lambda=lambda)
  
}


