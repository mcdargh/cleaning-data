# cleaning-data
UCI HAR database clean-up/summary

Files contained include
- this readme
- CodeBook.md
- run_analysis.R
- UCI HAR dataset
- tidy_data.txt
 
The repo is used to create a summary tidy data set for the test and training data from the UCI HAR dataset (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

# Pre-requisites
- R installed
- this repo downloaded

# Steps to produce the tidy dataset
- run the run_analysis.r script file

# Operation description
 - The script will load the training dataset adding descriptive column names from the features.txt file
 - It will then load the subjects and the activities
 - The process will repeat for the test data set.
 - The datasets will be merged together by appending the rows together.
 - The columns which contain mean and std values will be selected
 - The resulting dataset will have descriptive activity names applied using the activity_labels.txt file
 - Finally, a summary dataset will be created by grouping the dataset by subject and activity. Each group will then be processed by computing the mean value for each variable.  
 
# Result
The resulting dataset contains one row per subject and activity and the variables are the mean of the observerations for that variable for the subject/activity pairing.  For example, if Subject 1 had 10 rows for walking then there will be 1 row for subject 1 walking and each variable is the mean of the 10 individual rows.
