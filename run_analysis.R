# This R script does the following 

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 

# 5. Creates a second, independent tidy data set with the average of each variable
# for each activity and each subject.

library(plyr)

#Reading files which contain train and test datasets
#Giving appropriate labels to subject and activity class

train.data <- read.table("./UCI HAR Dataset/train/X_train.txt")
train.act <- read.table("./UCI HAR Dataset/train/y_train.txt",col.names = c("activityClass"))
train.subject <- read.table("./UCI HAR Dataset/train/subject_train.txt",col.names = c("subject"))

test.data <- read.table("./UCI HAR Dataset/test/X_test.txt")
test.act <- read.table("./UCI HAR Dataset/test/y_test.txt",col.names = c("activityClass"))
test.subject <- read.table("./UCI HAR Dataset/test/subject_test.txt",col.names = c("subject"))


# Labelling Variables###############################

#Extracting features' names from the file and labelling data sets accordingly. It would be
#easy to access data with proper labels.

features <- read.table("./UCI HAR Dataset/features.txt", col.names = c("ID", "feature_name"))
names(train.data) <- features[,2]
names(test.data) <- features[,2]

# [Step 1]##########################################

#Preparing train and test individually
train.data <- cbind(train.data,train.subject,train.act)
test.data <- cbind(test.data,test.subject,test.act)

# Merging of train and test data set
complete.data <- rbind(train.data,test.data)

# [Step 2]###########################################

# Extracting only measurements on mean and standard daviation for each measurement. Here,
# patterns are given as "-mean()" and "-std() specifically to exclude meanFreq() measurement.

features.index <- grep("-(mean|std)\\(\\)", features[,2])
complete.data <- complete.data[ , c(features.index,562,563)] 
#also included subject(Column 562 in old frame) and activityClass(Column 563 in old frame)

# [Step 3]###########################################

activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
complete.data$activityClass <- activities[complete.data$activityClass, 2] 
#replaced classes with labels

# [Step 4]###########################################
# Labels are assigned in initial steps. 
# Modifying labels according to R style guide 

modifiedNames <- names(complete.data)
modifiedNames <- sub("-", "", modifiedNames)            # Removing "-"
modifiedNames <- sub("\\(\\)", "", modifiedNames)       # Removing brackets   
modifiedNames <- sub("mean", "Mean", modifiedNames)     # Making first letter capital for mean and std
modifiedNames <- sub("std", "Std", modifiedNames)
modifiedNames <- sub("-X", "X", modifiedNames)          # Removing "-" for Axis
modifiedNames <- sub("-Y", "Y", modifiedNames)
modifiedNames <- sub("-Z", "Z", modifiedNames)
names(complete.data)<-modifiedNames

# [Step 5]###########################################

meanData <- ddply(complete.data, .(subject, activityClass), function(x) colMeans(x[, 1:66]))

# Writing tidy data to new file
write.table(meanData, file = "tidydata.txt", row.names = FALSE)

