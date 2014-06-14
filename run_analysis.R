##Load Data from Data set
xTestData <- read.table("./UCI HAR Dataset/test/X_test.txt")
yTestData <- read.table("./UCI HAR Dataset/test/y_test.txt")
testSubjectData <- read.table("./UCI HAR Dataset/test/subject_test.txt")
xTrainData <- read.table("./UCI HAR Dataset/train/X_train.txt")
yTrainData <- read.table("./UCI HAR Dataset/train/Y_train.txt")
trainSubjectData <- read.table("./UCI HAR Dataset/train/subject_train.txt")
featuresData <- read.table("./UCI HAR Dataset/features.txt")

##Begin Data Prep and Merge
featuresDataPro <- featuresData$V2
yData <- rbind(yTestData, yTrainData)
names(yData) <- "activity"
xData <- rbind(xTestData, xTrainData)
names(xData) <- featuresDataPro
subjectData <- rbind(testSubjectData, trainSubjectData)
xyData <- cbind(subjectData, yData, xData)


##Begin to Tiday Data Set 1 xyData
colnames(xyData)[1] <- "subject"
colnames(xyData)[2] <- "activity"
xyData <- xyData[,grep("(subject|activity|mean\\(\\)|std)", names(xyData), 
        value=TRUE)]
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
names(activityLabels) <- "activity"
xyData <- merge(xyData, activityLabels, by ="activity")
##Keep only Mean and Standard Deviation measurements
## and reorder with subject first
xyData <- xyData[,c(2,69,3:68)]
colnames(xyData)[2] <- "activity"

##Variable Name Cleanup of xyData
names(xyData) <- gsub("-mean()", " Mean ", names(xyData))
names(xyData) <- gsub("-std()", " Standard Deviation ", names(xyData))
names(xyData) <- gsub("-X", " Of X Axis", names(xyData))
names(xyData) <- gsub("-Y", " Of Y Axis", names(xyData))
names(xyData) <- gsub("-Z", " Of Z Axis", names(xyData))
names(xyData) <- gsub("tBodyAcc ", "filtered Body Acceleration Signal ",
     names(xyData))
names(xyData) <- gsub("tGravityAcc ", "filtered Gravity Acceleration Signal ",
     names(xyData))
names(xyData) <- gsub("tBodyAccJerk ", "derived Body Acceleration Jerk Signal",
     names(xyData))
names(xyData) <- gsub("tBodyGyro ", "filtered Body Gyroscope Signal ", 
     names(xyData))
names(xyData) <- gsub("tBodyGyroJerk ", "derived Body Gyroscope Jerk Signal",
     names(xyData))
names(xyData) <- gsub("tBodyAccMag ", "calculated Body Acceleration Magnitude",
     names(xyData))
names(xyData) <- gsub("tGravityAccMag ", "calculated Gravity Acceleration Magnitude",
     names(xyData))
names(xyData) <- gsub("tBodyAccJerkMag ", "calculated Body Acceleration Jerk Magnitude"
     , names(xyData))
names(xyData) <- gsub("tBodyGyroMag ", "calculated Body Gyroscope Magnitude",
     names(xyData))
names(xyData) <- gsub("tBodyGyroJerkMag ", "calculated Body Gyroscope Jerk Magnitude",
     names(xyData))
names(xyData) <- gsub("fBodyAcc ", "fast Fourier Transform Body Acceleration Signal ",
     names(xyData))
names(xyData) <- gsub("fGravityAcc ", "fast Fourier Transform Gravity Acceleration Signal "
     , names(xyData))
names(xyData) <- gsub("fBodyAccJerk ", "fast Fourier Transform Body Acceleration Jerk Signal"
     , names(xyData))
names(xyData) <- gsub("fBodyGyro ", "fast Fourier Transform Body Gyroscope Signal "
     , names(xyData))
names(xyData) <- gsub("fBodyGyroJerk ", "fast Fourier Transform Body Gyroscope Jerk Signal "
     , names(xyData))
names(xyData) <- gsub("fBodyAccMag ", "fast Fourier Transform Body Acceleration Magnitude "
     , names(xyData))
names(xyData) <- gsub("fGravityAccMag ", "fast Fourier Transform Gravity Acceleration Magnitude "
     , names(xyData))
names(xyData) <- gsub("fBodyAccJerkMag ", "fast Fourier Transform Body Acceleration Jerk Magnitude "
     , names(xyData))
names(xyData) <- gsub("fBodyGyroMag ", "fast Fourier Transform Body Gyroscope Magnitude "
     , names(xyData))
names(xyData) <- gsub("fBodyGyroJerkMag ", "fast Fourier Transform Body Gyroscope Jerk Magnitude "
     , names(xyData))
names(xyData) <- gsub("fBodyBodyAccMag ", "fast Fourier Transform Body Body Acceleration Magnitude "
     , names(xyData))
names(xyData) <- gsub("fBodyBodyAccJerkMag ", "fast Fourier Transform Body Body Acceleration Jerk Magnitude "
     , names(xyData))
names(xyData) <- gsub("fBodyBodyGyroMag ", "fast Fourier Transform Body Body Gyroscope Magnitude "
     , names(xyData))
names(xyData) <- gsub("fBodyBodyGyroJerkMag ", "fast Fourier Transform Body Body Gyroscope Jerk Magnitude "
     , names(xyData))
names(xyData) <- gsub(" ", "", names(xyData))
names(xyData) <- gsub("\\(\\)", "", names(xyData))

##Begin creating of Tiday Data set 2, tidyData
xyDataMelt <- melt(xyData, id=c(1,2), measure.vars=3:68)
tidyData <- dcast(xyDataMelt, subject+activity ~variable, fun=mean)
colnames(tidyData)[3:68] <- paste("Average_of",colnames(tidyData)[3:68], sep = "_")

##Write Data to Text File
write.table(tidyData, file="tidyData.txt", row.names=FALSE)