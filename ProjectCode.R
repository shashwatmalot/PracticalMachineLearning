##### Basic initializations
graphics.off();
rm(list=ls()); 
cat("\014"); 
library(caret);

##### Data import and basic cleaning
Data1<-read.csv("pml-training.csv");
Data1<-Data1[,c(2:11,37:49,60:68,84:86,102,113,124,140,151:160)]; # removing unneccessary variables
Data1<-Data1[complete.cases(Data1),]; # removing non complete cases
Data2<-read.csv("pml-testing.csv");
Data2<-Data2[,c(2:11,37:49,60:68,84:86,102,113,124,140,151:159)]; # removing unneccessary variables
Data2<-Data2[complete.cases(Data2),]; # removing non complete cases

##### Data partition
set.seed(1);
inTrain<-createDataPartition(y=Data1$classe,p=0.75,list=FALSE); # Partitioning training data into training and testing subset
training<-Data1[inTrain,]; testing<-Data1[-inTrain,];

##### Model training
set.seed(1);
ModelFit1<-train(classe~.,method='rf',data=training); # fitting RF model on the training set. Caret Will automatically calculate the optimum parameter values using repeated bootstraping.
plot(ModelFit1); # Checking the optimum value of predictor selected by caret. The optimum value of 'mtry' parameter is ~36 with accuracy>99%

##### Model testing
Predictions1<-predict(ModelFit1,testing); # Prediction on the testing set
Accuracy1<-mean(Predictions1==testing$classe); # Accuracy on the testing set. Accuracy>99% is seen on this set.

### Final predictions on the problem set
FinalPredictions<-as.character(predict(ModelFit1,Data2)); 

