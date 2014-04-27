## Description

run_analysis.R is an R script that collects and cleans data collected from the accelerometes from a Samsung Galaxy S smartphone. A description of the process is outline below

* Script checks for the existance of the "UCI HAR Dataset" directory.
* The data from the "test/X_test.txt" and "train/X_train.txt" files in the "UCI HAR Dataset" directory are collected and merged together.
* The mean and standard deviation of each measurement in the dataset are extracted to a new dataset "mean_std_data".
* The "Activity" column is created by merging data from the "Y_test.txt" and "Y_train.txt" files and added to "mean_std_data".
* The "Subject" column is created by merging data from the "subject_test.txt" and "subject_train.txt" and added to "mean_std_data".
* A new dataset is created by taking the average values in the "mean_std_data" for each activity and subject.
* The new dataset is output to the "tidy_data.txt" file.
