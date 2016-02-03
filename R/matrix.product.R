#Performs matrix multiplaction for several matrix sizes 

MC <- 5

n.min <- 256 #nrows=ncols in matrix A,B
m <- c(1, 2, 4, 8, 16, 32, 64)



res <- matrix(0, length(m), MC)

for(j in 1:MC){
  
  cat("j:",j ,"\n")
  
  for(i in 1:length(m)){
    
    n <- m[i]*128
    p <- n
    
    A <- matrix(rnorm(n*p), n, p)
    B <- matrix(rnorm(n*p), p, n)
    
    cat("multiplier:", m[i] ,"\n")
    res[i,j] <- system.time(C <- A%*%B)[3]
    
  }
}

res <- apply(res, 1, mean)


if(!file.exists("matrix_multiplications_timings.RData")){
  av.timings <- res
  save(av.timings, file="matrix_multiplications_timings.RData")
}else{
  load("matrix_multiplications_timings.RData")
  av.timings <- cbind(av.timings, res)
  save(av.timings, file="matrix_multiplications_timings.RData")
}


