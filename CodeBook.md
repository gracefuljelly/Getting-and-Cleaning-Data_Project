This code book contains the data to indicate all the variables and summaries caculated in run_Analysis.R.
his file describes the variables, the data, and any transformations or work that I have performed to clean up the data.

A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
The run_analysis.R script performs the following steps to clean the data:
1. Read X_train.txt into trainDataset and X_test.txt into trainDataset and testDataset and using rbind() to merge both datasets into mergedDataset.
2. Read Y_train.txt into trainDataset and Y_test.txt into trainLabel and testLabel and using rbind() to merge both datasets into mergedLabel.
3. Read subject_train.txt and subject_test.txt into trainSubject and testSubject and using rbind() to merge both datasets into mergedSubject.
4. Read the features.txt  into featureDataset. I used grep() to get the index for all mean and standard deviation.I saved all the indices to meanStdIndex. I subset the featureDataset using these indices.
6. Read the activity_labels.txt file and store the data in a variable called activityLabel.I also remove the "_"and make the activity label all lower case. 
7. I use the second column to activityLabel value to replace the number in mergedLabel from step2.
8. Lookup the value of mergedLabel using the indices we saved in step4 meanStdIndex and assign that dataset as the column name to mergedDataset.
9. Again, lower case and remove () from the column name in mergedDataset.
10. Combined mergedSubject, mergedActivity and mergedDataset to get cleanData. This is exported to merged_data.txt using write.table() function in current working directory.
11. CleanData is a  10299x68 data frame.  The "subject" variable consists of integers that range from 1 to 30; the "activity" column contains 6 kinds of activity names; the rest 66 columns contain measurements that range from -1 to 1.
12.using melt() and dcast() from reshape2 package to reshape the dataset. The average is done by mean function inside dcast() for each activity and each subject.
13. Export to tidy_data.txt to the current working director using write.table() function. 
