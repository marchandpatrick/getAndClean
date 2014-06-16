createDataSet<- function(){
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
  ## - 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
  trainDataSubject <- read.table("../UCI HAR Dataset/train/subject_train.txt")
  ## - 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
  totalAccelerationX <- read.table("../UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt")
  ## - 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
  bodyAccelerationX <- read.table("../UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt")
  ## - 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 
  bodyGyroX <- read.table("../UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt")
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
  firstTidyDataset <- subset(consolidated,select=c(1:6,41:46,81:86))
  write.table(firstTidyDataset,file = "firstTidyDataset.txt",quote = FALSE , sep =  "\t")
  codebook <- data.frame(names(firstTidyDataset))
  names(codebook) <- c("varCode")
  write.csv(codebook, file="codebookfirstTidyDataset.csv")
  # mean of each column
  secondTidyDataset <- colMeans(firstTidyDataset)
  write.table(secondTidyDataset,file = "secondTidyDataset.txt",quote = FALSE , sep =  "\t")
  codebook <- data.frame(names(secondTidyDataset))
  names(codebook) <- c("varCode")
  write.csv(codebook, file="codebooksecondTidyDataset.csv")
  
}
