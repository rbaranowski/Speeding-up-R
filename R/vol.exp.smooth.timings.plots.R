#This script produces tikz plots based on the timings data in matrix_multiplications_timings.RData file


require(ggplot2)
require(tikzDevice)
require(reshape2)

################################################

load("vol_exp_smooth_timings.RData")

##############################################
timings$n <- as.factor(timings$n)
plot.data <- melt(timings, id="n", value.name = "time")

colnames(plot.data)[2] <- "method"

fmt <- function(){
  f <- function(x) as.character(round(x,2))
  f
}

tikz(file="../tikz/vol_exp_smooth_logscale.tex", width=7, height=3.5)


pl.logscale <- ggplot(plot.data, aes(x=n, y=time, colour=method, shape=method))+geom_point(size=3) + 
  scale_y_continuous(trans="log2", labels = fmt()) + xlab("$n$")+theme_bw()+scale_colour_manual(values = c("red", "black", "yellow", "green"))

pl.logscale

dev.off()


tikz(file="../tikz/vol_exp_smooth_normalscale.tex", width=7, height=3.5)

pl.normalscale <- ggplot(plot.data, aes(x=n, y=time, colour=method, shape=method))+geom_point(size=3) + 
  scale_y_continuous(trans="identity", labels = fmt()) + xlab("$n$")+theme_bw()+scale_colour_manual(values = c("red", "black", "yellow", "green"))

pl.normalscale


dev.off()


