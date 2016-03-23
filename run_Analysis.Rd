##run_analysis.R
##First task, merging the test and training data. This assumes that the person running this script has already done the following:
## 1) Set their working directory
## 2) Downloaded the zip file to their desired working directory
## 3) Unzipped their file


##Loading libraries
library(plyr)
library(data.table)
library(dplyr)

##Loading files
test_data <- read.table("./test/X_test.txt")
training_data <-read.table("./train/X_train.txt")
test_data_activities <- read.table("./test/Y_test.txt", col.names = "Activity")
train_data_activities <- read.table("./train/Y_train.txt", col.names = "Activity")
features_labels <- read.table("./features.txt")
Subject_test_data <- read.table("./test/subject_test.txt", col.names = "Subject")
Subject_train_data <- read.table("./train/subject_train.txt", col.names = "Subject")

##Adding the labels for the columns (the features vector labels) to merged data set.

colnames(test_data) <- t(features_labels[2])
colnames(training_data) <- t(features_labels[2])

##Adding activities to the data

test_data_activity <- cbind(test_data_activities, test_data)
train_data_activity <- cbind(train_data_activities, training_data)

##Adding the participants to the data

test_data_complete <- cbind(Subject_test_data, test_data_activity)
training_data_complete <- cbind(Subject_train_data, train_data_activity)

##Part 1: Merge the test and training data together using rbind

complete_data <- rbind(test_data_complete, training_data_complete)
complete_data_noduplicates <- complete_data[, !duplicated(colnames(complete_data))]
activities_subjects_cols <- complete_data_noduplicates[,c(1:2)]

##Part 2: Select the mean() and std() measurements for each variable

extract_data_means <- select(complete_data_noduplicates, contains("mean()"))
extract_data_stds <- select(complete_data_noduplicates, contains("std()"))
extracted_data <- cbind(activities_subjects_cols, extract_data_means, extract_data_stds) ##lost the activities and subjects data in the extraction, so adding back.

##Part 3: Name the activities in the data set

extracted_data$Activity <- as.character(extracted_data$Activity)
extracted_data$Activity[extracted_data$Activity == 1] <- "Walking"
extracted_data$Activity[extracted_data$Activity == 2] <- "Walking Upstairs"
extracted_data$Activity[extracted_data$Activity == 3] <- "Walking Downstairs"
extracted_data$Activity[extracted_data$Activity == 4] <- "Sitting"
extracted_data$Activity[extracted_data$Activity == 5] <- "Standing"
extracted_data$Activity[extracted_data$Activity == 6] <- "Laying"
extracted_data$Activity <- as.factor(extracted_data$Activity)

##Part 4: Descriptive Names for the Columns
names(extracted_data) <- gsub("^t", "Time ", names(extracted_data))
names(extracted_data) <- gsub("^f", "Frequency ", names(extracted_data))
names(extracted_data) <- gsub("-mean\\(\\)", " Mean", names(extracted_data))
names(extracted_data) <- gsub("-std\\(\\)", " Standard Deviation", names(extracted_data))
names(extracted_data) <- gsub("-", " ", names(extracted_data))
names(extracted_data) <- gsub("BodyBody", "Body", names(extracted_data)) ##fixes duplicate BodyBody naming in six columns.
names(extracted_data) <- gsub("Acc", " Accelerator", names(extracted_data))
names(extracted_data) <- gsub("Mag", " Magnitude", names(extracted_data))
names(extracted_data) <- gsub("Gyro", " Gyroscope", names(extracted_data))
names(extracted_data) <- gsub("Jerk", " Jerk", names(extracted_data))

##Part 5 Create the tidy data set
tidy_data <- extracted_data %>% group_by(Subject, Activity) %>% summarize_each(funs(mean))

##Write the file
write.table(tidy_data, "tidy_UCI_HAR_means.txt", row.names = FALSE)

print(tidy_data)








