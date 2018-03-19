install.packages('Ecdat')
library(Ecdat)
library(corrplot)
library(caret)
library(glmnet)
data("VietNamI")
str(VietNamI)
p.cor<-cor(VietNamI[,-4])
corrplot.mixed(p.cor)
VietNamI$commune<-NULL
VietNamI_reduced<-VietNamI[1:1000,]
ind<-sample(2,nrow(VietNamI_reduced),replace=T,prob = c(0.7,0.3))
train<-VietNamI_reduced[ind==1,]
test<-VietNamI_reduced[ind==2,]
grid<-expand.grid(.alpha=seq(0,1,by=.5),.lambda=seq(0,0.2,by=.1))
control<-trainControl(method = "LOOCV")
enet.train<-train(illdays~.,train,method="glmnet",trControl=control,tuneGrid=grid)
enet.train

train$sex<-model.matrix( ~ sex - 1, data=train ) #convert to dummy variable 
test$sex<-model.matrix( ~ sex - 1, data=test )
predictor_variables<-as.matrix(train[,-9])
days_ill<-as.matrix(train$illdays)
enet<-glmnet(predictor_variables,days_ill,family = "gaussian",alpha = 0.5,lambda = .2)

enet.coef<-coef(enet,lambda=.2,alpha=.5,exact=T)
enet.coef

test.matrix<-as.matrix(test[,-9])
enet.y<-predict(enet, newx = test.matrix, type = "response", lambda=.2,alpha=.5)


plot(enet.y)


enet.resid<-enet.y-test$illdays
mean(enet.resid^2)


set.seed(317)
enet.cv<-cv.glmnet(predictor_variables,days_ill,alpha=.5)
plot(enet.cv)

enet.cv$lambda.min
enet.cv$lambda.1se

coef(enet.cv,s="lambda.1se")


enet.y.cv<-predict(enet.cv,newx = test.matrix,type='response',lambda="lambda.1se", alpha = .5)
enet.cv.resid<-enet.y.cv-test$illdays
mean(enet.cv.resid^2)