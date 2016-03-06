Getting and Cleaning Data: Course Project
=========================================

Introduction
------------
The repo is for the Coursera course "Getting and Cleaning data" project 

Raw data
------------------
The raw data can be  downloaded from  the link below : 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Here is the list of files used in this project


* train/X_train.txt
* test/X_test.txt

* train/y_train.txt
* test/y_test.txt

* test/subject_test.txt
* train/subject_train.txt

* features.txt
* activity_labels.txt

   1. values of Varible Activity consist of data from “Y_train.txt” and “Y_test.txt”;
   2. values of Varible Subject consist of data from “subject_train.txt” and              subject_test.txt";
   3. Values of Varibles Features consist of data from “X_train.txt” and “X_test.txt”;
   4. Names of Varibles Features come from “features.txt”
   5. levels of Varible Activity come from “activity_labels.txt”


The script and the tidy dataset
-------------------------------------
Name of the script : run_analysis.R 

The script contains the process below 

* setup work directory and create a data folder if not exist to download zip files
* un-zip files to UCI HAR Dataset folder
* convert the txt files used in this project to data frame 
then  process the following : 
     1. Merges the training and the test sets to create one data set.
     2. Extracts only the measurements on the mean and standard deviation for each measurement.
     3. Uses descriptive activity names to name the activities in the data set
     4. Appropriately labels the data set with descriptive variable names.
     5. From the data set in step 4, creates a second, independent tidy dataset with the average of each variable for each activity and each subject.

Tidy dataset containing the means of all the columns for each subject and each activity.
This tidy dataset will be written to a tab-delimited file called tidy.txt, which can also be found in this repo.

CodeBook
-------------------
The CodeBook.md file explains the details of transformations performed and the resulting data and variables.

------------------

