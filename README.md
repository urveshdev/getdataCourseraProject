# Course Project - Getting and Cleaning data
The files are submitted here as a part of getting and cleaning data course. 
The goal is to prepare tidy data from raw data [1] that can be used for later analysis.

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

Here are the data for the project:                                          
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## File structure
1. README.md - contains information about the files in directory
2. Codebook.md - contains information about the variables, the data, and any transformations performed to clean up the data
3. run_analysis.R - prepares tidy data useful for analysis from the raw dataset.
4. tidydata.txt - tidy data after running the script

## Steps to run Script
1. Unzip the data in current working directory
2. Current Working directory should contain a folder named "UCI HAR Dataset" which has all required files.
3. Run "run_analysis.R" script
4. Tidy data is stored in the file "tidydata.txt"
5. To read the tidy data,                                       
data <- read.table("tidydata.txt", header = TRUE)

## How Script works
1. Reads the training and testing source files from data set,also gives appropriate names to columns.
    It also reads features.txt to extract feature names.
2. Does labelling of feature measurements in training and testing data for ease of use
3. Merges the training and the test sets to create one data set.
4. Uses descriptive activity names to name the activities in the data set.
    Activity labels are taken from activity_labels.txt
5. Extracts only the measurements on the mean and standard deviation for each measurement.                        
    Here, only measurements of mean() and std() are considered . patterns are given as "-mean()" and "-std()            specifically to exclude measurements like meanFreq().
6. Modifies labels keeping Google's R style guide into consideration for human readability
7. Creates a second, independent tidy data set with the average of each variable. ddply() function is used.
8. Writes this new data to "tidydata.txt" file for further use.
