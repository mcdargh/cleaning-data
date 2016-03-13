# is the dplyr library installed?  If not, load it
if ("dplyr" %in% rownames(installed.packages()) == FALSE) {
    install.packages("dplyr")
}
# load the dplyr package 
library(dplyr)

# is the data table library installed?  If not, load it
if ("data.table" %in% rownames(installed.packages()) == FALSE) {
    install.packages("data.table")
}
# load the data table package
library(data.table)

# load in the features names to apply to both training and test data
feature_name_tbl <- read.table(file.path("UCI HAR Dataset", "features.txt"), header = FALSE)
# extract a list of names
feature_names <- as.vector(feature_name_tbl$V2)

# load in the activity names
activities <- read.table(file.path("UCI HAR Dataset", "activity_labels.txt"), header = FALSE)

load_data <- function(name) {
    # load data
    data <- read.table(file.path("UCI HAR Dataset", name, paste("X_", name, ".txt", sep = "")), header = FALSE)
    # apply column names to dataset
    colnames(data) <- feature_names
    # load subjects
    subjects <- read.table(file.path("UCI HAR Dataset", name, paste("subject_", name, ".txt", sep = "")), header = FALSE, col.names = "subject")
    # load activities
    activities <- read.table(file.path("UCI HAR Dataset", name, paste("y_", name, ".txt", sep = "")), header = FALSE, col.names = "activity")
    # merge three datasets into a merged one linking the subject with the activity and the data
    merged <- cbind(subjects, activity = activities, data)
    return(merged)
}

# load train data
training_data <- load_data("train")
# load test data
test_data <- load_data("test")

# merge the training and the test data together
merged <- rbind(training_data, test_data)

# make a new dataset which only contains the mean and std measurements
#
# to do this, grab a vector using the feature table to make column indexes
indexes <- grep("mean|std", feature_name_tbl$V2, ignore.case = TRUE)
# add two to each index because the first two columns in our dataset are for subject and activity
indexes <- indexes + 2
# now add the two columns for subject and activity
indexes <- c(1, 2, indexes)
extract <- merged[, indexes]
# use the activities table to give the activities their text name
final <- mutate(extract, activity = activities$V2[activity])

# now create a second dataset to summarize
summ <- final %>%
    group_by(subject, activity) %>%
    summarize_each(funs(mean))

# write out this dataset
write.table(summ, file = "tidy_data.txt", row.names = FALSE)


# END :)