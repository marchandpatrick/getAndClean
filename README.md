Getting and Cleaning Data
by Jeff Leek, PhD, Roger D. Peng, PhD, Brian Caffo, PhD

Course Project

Files:
run_analysis.R script to obtain both tidydatasets
firstTidyDataset.txt contains only the measurements on the mean and standard deviation for each measurement
secondTidyDataset.txt data set with the average of each variable for each activity and each subject
codebookfirstTidyDataset.txt.csv codebook for first dataset
codebooksecondTidyDataset.txt.csv codebook for second dataset

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

You should create one R script called run_analysis.R that does the following. 
1.Merges the training and the test sets to create one data set.

  ## - 'features.txt': List of all features.
  features <- read.table("../UCI HAR Dataset/features.txt",stringsAsFactors = FALSE)
  ## - 'activity_labels.txt': Links the class labels with their activity name.
  activityLabels <- read.table("../UCI HAR Dataset/activity_labels.txt")
  ## - 'train/X_train.txt': Training set.
  trainDataX <- read.table("../UCI HAR Dataset/train/x_train.txt")
  ## - 'train/y_train.txt': Training labels.
  trainDataY <- read.table("../UCI HAR Dataset/train/y_train.txt")
  ## - 'test/X_test.txt': Test set.
  testDataX <- read.table("../UCI HAR Dataset/test/x_test.txt")
  ## - 'test/y_test.txt': Test labels.
  testDataY <- read.table("../UCI HAR Dataset/test/y_test.txt")
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive activity names. 
  ## cleanup column names for features ( suppress exotic characters like parenthesis and dot)
  nameChange <- features[[2]]
  ## http://regex101.com/ to test regex expressions
  nameChange <- gsub("[(,)-]","",nameChange,)
  testDataset<-testDataX
  colnames(testDataset) <- nameChange
  names(testDataset)
  ## constitute the train dataset by adding to trainDatasetX the column V1 renamed activityCode from  traindatasetY
  activityCode <- (testDataY[["V1"]])
  testDataset$newcol <-activityCode
  colnames( testDataset)[562] <- "activityCode"
  ## first, set the name of columns for train dataset.
  ## add a column dataset; values are True for train dataset and False for Test dataset
  vectorTrueOrFalse <- rep(c(F),2947)
  testDataset$newcol <-vectorTrueOrFalse
  colnames( testDataset)[563] <- "isTrain"
  
  ## first, set the name of colunms for train dataset.
  trainDataset<-trainDataX
  ## assign cleaned names to colums
  colnames(trainDataset) <- nameChange
  names(trainDataset)
  ## Add a column from dataY renamed activityCode
  activityCode <- (trainDataY[["V1"]])
  trainDataset$newcol <-activityCode
  colnames( trainDataset)[562] <- "activityCode"
  ##
  vectorTrueOrFalse <- rep(c(T),7352)
  trainDataset$newcol <-vectorTrueOrFalse
  colnames( trainDataset)[563] <- "isTrain"  
  ## combine the content of both train and test datasets in one dataset named combinedDataset
  ##
  consolidated <- rbind (testDataset,trainDataset)
  names(consolidated)
2.Extracts only the measurements on the mean and standard deviation for each measurement. 
  firstTidyDataset <- subset(consolidated,select=c(1:6,41:46,81:86))
  write.table(firstTidyDataset,file = "firstTidyDataset.txt",quote = FALSE , sep =  "\t")
  codebook <- data.frame(names(firstTidyDataset))
  names(codebook) <- c("varCode")
  write.csv(codebook, file="codebookfirstTidyDataset.csv")
  # mean of each column
5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
  secondTidyDataset <- colMeans(firstTidyDataset)
  write.table(secondTidyDataset,file = "secondTidyDataset.txt",quote = FALSE , sep =  "\t")
  codebook <- data.frame(names(secondTidyDataset))
  names(codebook) <- c("varCode")
  write.csv(codebook, file="codebooksecondTidyDataset.csv")
  
  