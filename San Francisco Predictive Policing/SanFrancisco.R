
#remove unnecessary columns
train2<-train[-c(3,5,6,7)]
summary(train2)

#create week numbers
train2$week<-strftime(train2$Dates,format="%V")
train2$week<-as.numeric(train2$week)
unique(train2$week)


#create week day numbers
train2$day<-as.numeric(train2$DayOfWeek)
unique(train2$day)

#create time of day
train2$newDate<-as.Date(train2$Dates)

summary(train2)
head(train2$Dates)

train2$time<-strftime(train2$newDate,format="%H")
train2$time<-as.numeric(train2$time)
unique(train2$time)









set.seed(222)

test_ids<- sample(seq(nrow(train)), 
                  round(0.2 * nrow(train)))

for (k in 1:50) {
  knn_train   <- knn(train = train_data[test_ids,-2],
                         test = train_data[-test_ids,-2],
                         y = train_data[,2],
                         k = k)
  MSE_k[k]    <- mean((knn_train$pred - test_data[,2])^2)
}

