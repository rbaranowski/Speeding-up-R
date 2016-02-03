#This script produces tikz plots based on the timings data in matrix_multiplications_timings.RData file

n.min <- 256 #nrows=ncols in matrix A,B
m <- c(1, 2, 4, 8, 16, 32, 64) #multipliers
################################################
require(ggplot2)
require(tikzDevice)
require(reshape2)

################################################

load("matrix_multiplications_timings.RData")

##############################################

data <-cbind(n=as.factor(n.min*m), as.data.frame(av.timings))
colnames(data) <- c("n", "BLAS", "OpenBLAS", "NVBLAS")

plot.data <- melt(data, id="n", value.name = "time")
colnames(plot.data)[2] <- "lib"

fmt <- function(){
  f <- function(x) as.character(round(x,2))
  f
}

tikz(file="../tikz/matrix_multiplciations_logscale.tex", width=7, height=3.5)


pl.logscale <- ggplot(plot.data, aes(x=n, y=time, colour=lib, shape=lib))+geom_point(size=3) + 
  scale_y_continuous(trans="log2", labels = fmt()) + xlab("$n$")+theme_bw()+scale_colour_manual(values = c("red", "black", "navy"))

pl.logscale

dev.off()
  

tikz(file="../tikz/matrix_multiplciations_normalscale.tex", width=7, height=3.5)

pl.normalscale <- ggplot(plot.data, aes(x=n, y=time, colour=lib, shape=lib))+geom_point(size=3) + 
  scale_y_continuous(trans="identity", labels = fmt()) + xlab("$n$")+theme_bw()+scale_colour_manual(values = c("red", "black", "navy"))


pl.normalscale

dev.off()


