
setwd("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset")

## 1. Merge the training and the test sets to create one data set.
trainDataset<- read.table("./train/X_train.txt")
testDataset<-read.table ("./test/X_test.txt")
mergedDataset<- rbind(trainDataset,testDataset)

trainLabel<- read.table("./train/Y_train.txt")
testLabel <-read.table("./test/Y_test.txt")
mergedLabel <- rbind(trainLabel,testLabel)

trainSubject <-read.table("./train/subject_train.txt")
testSubject <- read.table ("./test/subject_test.txt")
mergedSubject  <-rbind(trainSubject,testSubject)

##2.Extract only the measurements on the mean and standard deviation for each measurement.
featureDataset <-read.table("./features.txt")
meanStdIndex <- grep("mean\\(\\)|std\\(\\)", featureDataset[,2]) ##get the index for all mean and standard deviation
mergedDataset <-mergedDataset[,meanStdIndex] 


##3. Uses descriptive activity names to name the activities in the dataset
activityLabel <-read.table("./activity_labels.txt")
activityLabel[,2] <-tolower(gsub("_","",activityLabel[,2]))

mergedLabel[,1]<-activityLabel[mergedLabel[,1],2] ##use the activityLabel[,2] value to replace the cooresponsive row number


##4. Appropriately labels the dataset with descriptive variable name
names(mergedDataset) <- featureDataset[meanStdIndex,2]## assign headers to the dataset
names(mergedDataset) <- gsub("-|\\(\\)", "",names(mergedDataset)) ## remove _ and () 
names(mergedDataset) <- tolower(names(mergedDataset)) ## all lower case when possible
names(mergedLabel) <-"activity"
names(mergedSubject) <-"subject" 

cleanData <-cbind(mergedSubject,mergedLabel,mergedDataset)
dim(cleanData)
write.table(cleanData,"merged_data.txt")

##5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(reshape2)
meltedDataset <- melt(cleanData, id = c("subject", "activity"))
meltedDataset
dcastDataset <- dcast(meltedDataset, subject + activity ~ variable, mean)
write.table(dcastDataset,"tidy_data.txt", row.name=FALSE)



