Below is a step by step description of the way I approached the machine learning project.

<h4>Preprocessing:</h4> 
Looking at the test set, it is quite clear that many variables are simply NA/empty vectors. I have removed these variables from both training and test set. After this step, we were left with a total of 48 predictors. Rows which do not have complete data are also removed using complete.cases() command.  We are left with a total of 19622 observations after the process. Summing up we have 48 predictors to predict 5 classes using ~20k observations.

<h4>Training and testing data set creation:</h4>
I have used the caret package to implement machine learning algorithms. The training set is partitioned into training and test subset using the createDataPartition() command. Test set is taken to be 25% of the original training set data(~5k observations). The remaining 75% is the training set(~15k observations).

<h4>Algorithm for classification:</h4>
I have chosen Random Forest algorithm for classification. This was done to improve over the performance of simpler algorithms(lda,rpart etc.) which were giving around 90% accuracy. The parameter of interest for the Random Forest algorithm is variables per level(mtry). I have randomly tried three values of this parameter: 2,36,70. For each of these values the following steps are performed:
1) 25 bootstrapped samples from the training set are created. Corresponding to each bootstrapped sample we have an out of bag data(OOB) sample. 
2) Random forests algorithm are trained on each of these bootstrapped samples. Their accuracy is calculated using predictions on OOB data from the trained model. 
3) An average of accuracy for the 25 samples is the estimated accuracy for that value of 'mtry' parameter.
All the three values give us above 98% accuracy, but the best value for 'mtry' is 36 which gives ~99.9% accuracy. The top five variable in order of importance are: raw_timestamp_part_1, num_window, roll_belt, yaw_belt and pitch_belt.

Plot1: variables per level vs bootstrap accuracy:
(Available along with the code)

Table1: Top five predicators: 
(Available along with the code)


<h4>Analysis on testing set:</h4>
The fitted model(with variables per level=36) is tried on the testing set to determine its out of sample accuracy. The out of sample accuracy I achieved was greater than 99.8%. This value was in line with the bootstrapping estimations. Since the above fitted model has a very good out of sample performance, I used the model on the final problem set.

<h4>Problem set:</h4>
The problem set consists of the 20 observations. An accuracy of 100% was observed after uploading the predictions.
