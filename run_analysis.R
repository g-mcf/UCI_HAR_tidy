##############################################################
#
# run_analysis.R
#
# This script performs the required analysis for 
# the programming assignment associated with 
# the Getting & Cleaning Data course, part of the
# Data Science Specialization from John Hopkins University
# on Coursera
#
# The assignment can be found here:
# https://class.coursera.org/getdata-003/human_grading/
# view/courses/972136/assessments/3/submissions
#
# Please refer to CodeBook.md for details on the data,
# the variables, the transformations and the work performed 
# to clean the data
#
# Please refer to the README.md for general details on the
# scripts
# 
##############################################################


# load required resources
library("data.table")
library("reshape2")

# set variables for the path names where each data set and information is stored
# your paths may be different than thos shown here.  If so change the rhs of the assignments.
path_home <- "~/Documents/Coursera/3_Getting and Cleaning Data/Assignment/UCI_HAR_Dataset"
path_test <- "~/Documents/Coursera/3_Getting and Cleaning Data/Assignment/UCI_HAR_Dataset/test/"
path_train <- "~/Documents/Coursera/3_Getting and Cleaning Data/Assignment/UCI_HAR_Dataset/train/"

# from the "home" directory select the feature names as a vector
setwd(path_home)
features <- as.vector(read.table("features.txt") [, 2])

# make the names conform to the Advanced R style guide 
# (see http://adv-r.had.co.nz/Style.html)
features <- make.names(features)
features <- gsub(".", "_", features, fixed = TRUE)
features <- gsub("__", "", features, fixed = TRUE)
features <- tolower(features)

# from the "home" directory read in the activity labels data as a vector
activity_labels <- as.vector(read.table("activity_labels.txt") [, 2])

# from the "test data" directory read in the X_test file and add column names
# from the features object set earlier
setwd(path_test)
features_data <- as.data.table(read.table("X_test.txt"))
setnames(features_data, features)

# select the columns that contain the mean and std deviation
# of the time and frequency domain data only
keep <- substr(features,1,1)
domain_only <- features[keep == "t" | keep == "f"]
means <- agrep("mean", domain_only)
stdevs <- agrep("std", domain_only)
full <- sort(c(means, stdevs))
features_data <- subset(features_data, select = full)

# from the "test data" directory read in the y_test file and add a column name
activity <- as.data.table(read.table("y_test.txt"))
setnames(activity, "activity_number")

# Use the activity_labels object set earlier to add and populate a column of activity names 
activity$activity_name <- activity_labels[activity$activity_number]

# from the "test data" directory read in the subject_test file and add a column name
test_subject <- as.data.table(read.table("subject_test.txt"))
setnames(test_subject, "test_subject")

# create the test dataset by combining the above objects
test_dataset <- cbind(test_subject, activity, features_data)

# remove objects that will be reset for the next set of data
rm(test_subject, activity, features_data, means, stdevs, 
   full, keep, domain_only)

# from the "train data" directory read in the X_train file and add column names
# from the d object set earlier
setwd(path_train)
features_data <- as.data.table(read.table("X_train.txt"))
setnames(features_data, features)

# select the columns that contain the mean and std deviation
# of the time domain data only
keep <- substr(features,1,1)
domain_only <- features[keep == "t" | keep == "f"]
means <- agrep("mean", domain_only)
stdevs <- agrep("std", domain_only)
full <- sort(c(means, stdevs))
features_data <- subset(features_data, select = full)

# from the "train data" directory read in the y_train file and add a column name
activity <- as.data.table(read.table("y_train.txt"))
setnames(activity, "activity_number")

# Use the activity_labels object set earlier to add and populate a column of activity names 
activity$activity_name <- activity_labels[activity$activity_number]

# from the "train data" directory read in the subject_train file and add a column name
test_subject <- as.data.table(read.table("subject_train.txt"))
setnames(test_subject, "test_subject")

# create the test dataset by combining the above objects
train_dataset <- cbind(test_subject, activity, features_data)

# remove objects that are no longer required
rm(test_subject, activity, features_data, means, stdevs, 
   full, keep, domain_only, features, activity_labels, 
   path_test, path_train)

# combine the train and test datasets into a single dataset
total_dataset <- rbind(test_dataset, train_dataset)

# sort the total dataset by Subject then by Activity
setkey(total_dataset, test_subject, activity_number)

# remove the datasets objects that are no longer required
rm(test_dataset, train_dataset)

# make the tidy data set per the instructions
tidy_total_dataset <- melt(total_dataset, 
                           id=c("test_subject","activity_number", "activity_name"))
tidy_total_dataset<-dcast(tidy_total_dataset, 
                          test_subject + activity_name ~ variable, fun.aggregate=mean)

# write the files to the "home" directory 
setwd(path_home)
write.csv(total_dataset, file = "UCI_Har_total.csv", row.names = FALSE)
write.csv(tidy_total_dataset, file = "UCI_Har_tidy.csv", row.names = FALSE)

# remove the total dataset object
rm(total_dataset)

# That's it. Thanks!
