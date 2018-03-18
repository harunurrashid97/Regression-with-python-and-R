install.packages("foreign")
library("foreign")
ml <- read.dta("http://www.ats.ucla.edu/stat/data/hsbdemo.dta")
head(ml)
ml$prog2 <- relevel(ml$prog, ref = "academic")
install.packages("nnet")
library("nnet")
test <- multinom(prog2 ~ ses + write, data = ml)
summary(test)
z <- summary(test)$coefficients/summary(test)$standard.errors
z
p <- (1 - pnorm(abs(z), 0, 1))*2
p
exp(coef(test))
names(ml)
levels(ml$female)
levels(ml$ses)
levels(ml$schtyp)
levels(ml$honors)
test <- multinom(prog2 ~ ., data = ml[,-c(1,5,13)])
summary(test)
head(fitted(test))
expanded=expand.grid(female=c("female", "male", "male", "male"),
                     ses=c("low","low","middle", "high"),
                     schtyp=c("public", "public", "private", "private"),
                     read=c(20,50,60,70),
                     write=c(23,45,55,65),
                     math=c(30,46,76,54),
                     science=c(25,45,68,51),
                     socst=c(30, 35, 67, 61),
                     honors=c("not enrolled", "not enrolled", "enrolled","not enrolled"),
                     awards=c(0,0,3,0,6) )
head(expanded)
predicted=predict(test,expanded,type="probs")
head(predicted)
bpp=cbind(expanded, predicted)
by(bpp[,4:7], bpp$ses, colMeans)
install.packages("reshape2")
library("reshape2")
bpp2 = melt (bpp,id.vars=c("female", "ses","schtyp", "read","write","math","science","socst",
                           "honors", "awards"),value.name="probablity")
head(bpp2)
library("ggplot2")
ggplot(bpp2, aes(x = write, y = probablity, colour = ses)) +
  geom_line() + facet_grid(variable ~ ., scales="free")
