Study design
===========

The raw data for this script come from the a dataset called Human Activity Recognition Using Smartphones Dataset.  

Information about the study is here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

As a pre-requesite, ensure you that you have the raw data in your working directory, here are the data: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The raw training and test data was merged by merging each 3 part data set (x_test and x_train), (y_test and y_train) as well as (subject_test and subject_train).  The 3 part data set is then merged into one via it's columns.

Only measurements about the subjects and activities that fit the criteria of having originally been a direct mean or standard deviation measurement was kept.  Each variable was then named in a descriptive fashion by substituting variable name chunks with the appropriate descriptive langauge.

This processed data was then run through a melt, such that all columns were treated as variables except for subject and activity.  The melt data was run through a dcast function in the reshape2 library which produced the mean of every variable by subject and activity.

Code book
===========

The subject column uniquely identifies 1 of 30 subjects.

activity column identifies 1 of 6 activities that the subjects performed.

The data set contains 66 variables, each in the other columns, and each of which was sourced from the raw data above as per the study design. 

All variable columns are means (aka Average_of in the column names) of the original raw data variables as per the study design.  Passing the variables through a 'mean' function to obtain the mean of that variable by its subject and activity was the only data treatment of the variable beyond what was done in the original data set.



