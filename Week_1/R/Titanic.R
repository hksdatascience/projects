#upload datasets from Kaggle
t<-train
t1<-test

#look at dataset
summary(t)
str(t)

#Remove unnecessary variables
t <- t[-c(1,4,8,9,11)]

#create dummy variable for sex
#Female as 1
#Male as 0
dummy <- as.numeric(t[,"Sex"]=='female')
t[,"Sex"] <-dummy

#clean up test data
t1 <- t1[-c(1,3,8,10,11)]

dummy <- as.numeric(t1[,"Sex"]=='female')
t1[,"Sex"] <-dummy


Titanic<-t

summary(Titanic)

#logistic regression on 3 variables
xyz <- glm(as.formula("Survived ~ Pclass + Sex + Fare"),
           family = binomial,
           data = Titanic)


#use logistic model on test data
x<- predict(xyz,
        test,
        type = "response")


#set threshold at 0.5
##Note: Should create confusion matrix to test threhold but ran out of time
prediction<-as.numeric(x > 0.5)

yz<-test

#add prediction as a column
yz$prediction<-prediction

#look at plot to make sure eye-ball correlation between fare and survival
plot(yz$Fare,yz$prediction)


yz1<-yz[c(1,12)]

#Create final csv file for submission
write.csv(yz1, file=file.path(getwd(),"TitanicPredictions.csv"),row.names = FALSE)

#76.6% correct on test data
