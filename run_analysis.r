#Getting and Cleaning Data Course Project

## Purpose of the poject 
# The purpose of this project is to demonstrate your ability to collect, 
# work with, and clean a data set. The goal is to prepare tidy data that 
# can be used for later analysis. You will be graded by your peers on a series of yes/no
# questions related to the project. You will be required to submit: 
# 1) a tidy data set as 
# described below, 2) a link to a Github repository with your script for performing 
# the analysis, and 3) a code book that describes the variables, 
# the data, and any transformations or work that you performed to clean up 
# the data called CodeBook.md. You should also include a README.md in the repo 
# with your scripts. This repo explains how all of the scripts work and how they are connected.
# 
#  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# 
# ## Data source 
# Here are the data for the project:
#         
#  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# ## Variables and Data information 
# ## Please refer to README.txt and features_info.txt for details

## Process of the project 
# You should create one R script called run_analysis.R that does the following.
# 
# * 1.Merges the training and the test sets to create one data set.
# * 2.Extracts only the measurements on the mean and standard deviation for each measurement.
# * 3.Uses descriptive activity names to name the activities in the data set
# * 4.Appropriately labels the data set with descriptive variable names.
# * 5.From the data set in step 4, creates a second, independent tidy data set with the average   of each variable for each activity and each subject.
# 
# 
### Files used in the project 
# 
# * "activity_labels.txt"                         
# * "features.txt"   
# * subject files :
# "test/subject_test.txt" ,
# "train/subject_train.txt" 
# * activtiy files :
# "test/y_test.txt" ,
# "train/y_train.txt"  
# * feature files :
# "test/X_test.txt" ,
# "train/y_train.txt" 

## Detail process of the project 

### download file  and put in data folder , named datasets.zip

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")

### un-zip files 
unzip(zipfile="./data/Dataset.zip",exdir="./data")

### unzip files saved under UCI HAR Dataset folder , list all files in the folder 
path_list<- file.path("./data" , "UCI HAR Dataset")
files<-list.files(path_list, recursive=TRUE)
files

### read txt files above  and convert to data frame :

### subject files 
dataSubject_Train <- read.table(file.path(path_list, "train", "subject_train.txt"),header = FALSE)
dataSubject_Test  <- read.table(file.path(path_list, "test" , "subject_test.txt"),header = FALSE)

### activities files 
dataactivity_Train <- read.table(file.path(path_list, "train", "y_train.txt"),header = FALSE)
dataactivity_Test  <- read.table(file.path(path_list, "test" , "y_test.txt"),header = FALSE)

### features files 
data_Train <- read.table(file.path(path_list, "train", "x_train.txt"),header = FALSE)
data_Test  <- read.table(file.path(path_list, "test" , "x_test.txt"),header = FALSE)

### Look at data structure ( Description of data and variables  )

str(dataSubject_Train)
str(dataSubject_Test)

str(dataactivity_Train)
str(dataactivity_Test)

str(data_Train)
str(data_Test)


## 1. Merges the training and testing datasets  to one data 
dataSubject <- rbind(dataSubject_Train, dataSubject_Test)
dataActivity<- rbind(dataactivity_Train, dataactivity_Test)
data_vars<- rbind(data_Train, data_Test)

### add names to variables in each table 

names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
data_varsNames <- read.table(file.path(path_list, "features.txt"),head=FALSE)
names(data_vars)<- data_varsNames$V2


### merge all three datasets to one 

dataC1<- cbind(dataSubject, dataActivity)
Data_all <- cbind(data_vars, dataC1) 



## 2.Extracts only the measurements on the mean and standard deviation for each measurement.


subdataNames<-data_varsNames$V2[grep("mean\\(\\)|std\\(\\)", data_varsNames$V2)]
selected_names<-c("subject","activity",as.character(subdataNames))
Data_all<-subset(Data_all,select=selected_names)



## 3. Uses descriptive activity names to name the activities in the data set 
### create factor of activity var and add label from actitiy_labels.txt

activityLabels <- read.table(file.path(path_list, "activity_labels.txt"),header = FALSE)

Data_all$activity <- factor(Data_all$activity, labels = activityLabels[,2])

### check the results 
head(Data_all$activity,5)

##4. Propriately labels the data set with descriptive variable names.
###  information is from features_info.txt

# * prefix t is replaced by time
# * Acc is replaced by Accelerometer
# * Gyro is replaced by Gyroscope
# * prefix f is replaced by frequency
# * Mag is replaced by Magnitude
# * BodyBody is replaced by Body


### name before 
names(Data_all) 

names(Data_all)<-gsub("^t", "time", names(Data_all))
names(Data_all)<-gsub("^f", "frequency", names(Data_all))
names(Data_all)<-gsub("Acc", "Accelerometer", names(Data_all))
names(Data_all)<-gsub("Gyro", "Gyroscope", names(Data_all))
names(Data_all)<-gsub("Mag", "Magnitude", names(Data_all))
names(Data_all)<-gsub("BodyBody", "Body", names(Data_all))

### names after 
names(Data_all)

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(plyr);
?aggregate
tidydata<-aggregate(. ~subject + activity, Data_all, mean)


### Output tidydata to txt 
write.table(tidydata, file = "tidydata.txt",row.name=FALSE)

### Description of tidydata and variables 
head(str(tidydata),2)

####The tidydata  contains sets of variables for each activity and each subject
####there are 180 rows with 68 variables- 33 means and 33 Standard deviation variables , 1 subject variable and 1 activity variable .

