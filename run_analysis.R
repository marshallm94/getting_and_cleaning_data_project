#All subsequent code is based on the assumption that the working directory is 
#set to where all necessary data files are located (not separate directories, 
#one directory for all files; files retain original names and extensions)

setwd('/Users/marsh/Downloads/uci_har_dataset')
library(dplyr)

#Part 1
mktraindata <- function() {
      train_subjects <- read.table('subject_train.txt')
            train_subjects <- rename(train_subjects, subjectID = V1)
                  train_subjects <- tbl_df(train_subjects)
      train_labels <- read.table('y_train.txt')
            train_labels <- rename(train_labels, activityID = V1)
                  train_labels <- tbl_df(train_labels)
      train_main <- read.table('x_train.txt')
            train_main <- tbl_df(train_main)
      features <- read.table("features.txt")
            features <- tbl_df(features)
            features <- features[,2]
            features <- rename(features, measurements = V2)
      colnames(train_main) <- features$measurements
      train_data <- cbind(train_subjects, train_labels, train_main)
}

#Part 2
mktestdata <- function() {
      test_subjects <- read.table('subject_test.txt')
            test_subjects <- rename(test_subjects, subjectID = V1)
                  test_subjects <- tbl_df(test_subjects)
      test_labels <- read.table('y_test.txt')
            test_labels <- rename(test_labels, activityID = V1)
                  test_labels <- tbl_df(test_labels)
      test_main <- read.table('x_test.txt')
            test_main <- tbl_df(test_main)
      colnames(test_main) <- features$measurements      
      test_data <- cbind(test_subjects, test_labels, test_main)      
}

#Part 3
finaldata <- rbind(train_data, test_data)

#Part 4
finaldata$activityID <- gsub('1','walking', finaldata$activityID)
finaldata$activityID <- gsub('2','walking-upstairs', finaldata$activityID)
finaldata$activityID <- gsub('3','walking-downstairs', finaldata$activityID)
finaldata$activityID <- gsub('4','sitting', finaldata$activityID)
finaldata$activityID <- gsub('5','standing', finaldata$activityID)
finaldata$activityID <- gsub('6','laying', finaldata$activityID)

#Part 5
newnames <- grep('[Mm]ean()|std()', colnames(finaldata))
finaldata <- finaldata[,c(1,2,newnames)]

#Part 6
finaldata_2 <- group_by(finaldata, subjectID, activityID)
finaldata_2 <- summarize_all(finaldata_2, mean)

finaldata_2

