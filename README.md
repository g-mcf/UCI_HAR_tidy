README.MD
-----------------------------

### Introduction

The **UCI_Har_tidy** dataset summarizes a subset of raw data according to [Tidy Data Principles](http://vita.had.co.nz/papers/tidy-data.pdf).  The codebook for this dataset including information on its source, and the script used to create it can be found on Github at (https://github.com/g-mcf/UCI_HAR_tidy).  

This file describes the key elements of the script used to tidy the raw data.  The script itself is fully annotated.

### Details of the script

The script assumes that the raw data has been downloaded from the source to your working directory.  Set path variables to ease changes in the working directory.  You paths are likely different than those shown below.

```
path_home <- "~/Documents/Coursera/3_Getting and Cleaning Data/Assignment/UCI_HAR_Dataset"
path_test <- "~/Documents/Coursera/3_Getting and Cleaning Data/Assignment/UCI_HAR_Dataset/test/"
path_train <- "~/Documents/Coursera/3_Getting and Cleaning Data/Assignment/UCI_HAR_Dataset/train/"
```

Start in the "home" directory.  Read in the feature names.  The feature names require transformation to conform with R style convention, such as those shown in the [Advanced R style guide](http://adv-r.had.co.nz/Style.html)

``` 
setwd(path_home)
features <- as.vector(read.table("features.txt") [, 2])
features <- make.names(features)
features <- gsub(".", "_", features, fixed = TRUE)
features <- gsub("__", "", features, fixed = TRUE)
features <- tolower(features)
```

Read in the activity labels.

```
activity_labels <- as.vector(read.table("activity_labels.txt") [, 2])
```

Change to the "test data" directory.  Read in the test data and manipulate it to select only the variables that are required per the project scope. Select the columns that contain the features mean and std deviation data and label appropriately.

```
setwd(path_test)
features_data <- as.data.table(read.table("X_test.txt"))
setnames(features_data, features)
keep <- substr(features,1,1)
domain_only <- features[keep == "t" | keep == "f"]
means <- agrep("mean", domain_only)
stdevs <- agrep("std", domain_only)
full <- sort(c(means, stdevs))
features_data <- subset(features_data, select = full)
```

Read in the activity data and label it.  Add and populate a column of activity names.

```
activity <- as.data.table(read.table("y_test.txt"))
setnames(activity, "activity_number")  
activity$activity_name <- activity_labels[activity$activity_number]
```

Read in the subject_test file data and add a column name.

```
test_subject <- as.data.table(read.table("subject_test.txt"))
setnames(test_subject, "test_subject")
```

Assemble the "test" dataframe/data table using the objects created above.

```
test_dataset <- cbind(test_subject, activity, features_data)
```

Change to the "train data" directory" and repeat the steps above to create the "train" dataframe/data table.

```
train_dataset <- cbind(test_subject, activity, features_data)
```

Combine the train and test datasets into a single dataset and sort the total dataset by Subject then by Activity

```
total_dataset <- rbind(test_dataset, train_dataset)
setkey(total_dataset, test_subject, activity_number)
```

Create the tidy data set per the project requirements.

```
tidy_total_dataset <- melt(total_dataset, 
                           id=c("test_subject","activity_number", "activity_name"))
tidy_total_dataset<-dcast(tidy_total_dataset, 
                          test_subject + activity_name ~ variable, fun.aggregate=mean)
```

Finally, write the files to the "home" directory.

```
setwd(path_home)
write.csv(total_dataset, file = "UCI_Har_total.csv", row.names = FALSE)
write.csv(tidy_total_dataset, file = "UCI_Har_tidy.csv", row.names = FALSE)
```

That's all.  Thanks for your time!


