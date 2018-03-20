## ------------------------------------------------------------------------
mhours <- read.csv("http://www.personal.psu.edu/~mar36/stat_462/manhours.csv",header=T)
library(psych)
pairs.panels(mhours[,-1],ellipses=FALSE,smooth=FALSE,lm=TRUE)

## ----eval=FALSE----------------------------------------------------------
summary(lm(hours~ocup,data=mhours))
summary(lm(hours~check,data=mhours))
summary(lm(hours~service,data=mhours))
summary(lm(hours~sqfoot,data=mhours))
summary(lm(hours~wings,data=mhours))
summary(lm(hours~cap,data=mhours))
summary(lm(hours~rooms,data=mhours))

## ----eval=FALSE----------------------------------------------------------
summary(lm(hours~ocup+check+service+sqfoot+wings+cap+rooms,data=mhours))
summary(lm(hours~(ocup+check+service+sqfoot+wings+cap+rooms)^2,data=mhours))

## ----eval=FALSE----------------------------------------------------------
# Starring point
start <- lm(hours~1,data=mhours)
summary(start)
# Ending point
end <- lm(hours~ocup+check+service+sqfoot+wings+cap+rooms,data=mhours)
summary(end)
# Use the "step" function
step(start,scope=list(upper=end),direction="forward",test="F")
res.f <- step(start,scope=list(upper=end),direction="forward",test="F")
summary(res.f)

## ----eval=FALSE----------------------------------------------------------
res.f2 <- step(start,scope=list(upper=end),direction="forward",
               test="F",k=4)
summary(res.f2)

## ----eval=FALSE----------------------------------------------------------
res.b <- step(end,direction="backward",test="F")
summary(res.b)

## ----eval=FALSE----------------------------------------------------------
res.both <- step(start,scope=list(upper=end),direction="both",test="F")
summary(res.both)

## ----eval=FALSE----------------------------------------------------------
end.i <- lm(hours~(ocup+check+service+sqfoot+wings+cap+rooms)^2,data=mhours)
res.f3 <- step(start,scope=list(upper=end.i),direction="forward",test="F")
summary(res.f3)
res.f3$call

## ----eval=FALSE----------------------------------------------------------
end.p <- lm(hours~ocup+check+service+sqfoot+
              wings+cap+rooms+I(rooms^2)+I(cap^2)+I(check^2),data=mhours)
res.f4 <- step(start,scope=list(upper=end.p),direction="forward",test="F")
summary(res.f4)

## ----eval=FALSE----------------------------------------------------------
start <- lm(hours~check,data=mhours)
res.f4.2 <- step(start,scope=list(upper=end.p),direction="forward",
                 ,test="F")
summary(res.f4.2)

