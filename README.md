##Introduction##

In run_analysis.R, I have labeled various chunks of code as parts 1-6 and I will
explain them below accordingly. At the top of run_analysis.R there is an 
important note regarding the working directory that is ESSENTIAL for run_analysis.R
to function properly, so I will repeat it here.

"All subsequent code is based on the assumption that the working directory is 
set to where ALL necessary data files are located (not separate directories, 
one directory for all files; files retain original names and extensions)"

As stated above, I'm assuming all necessary files are located in one single
directory (when files are originally downloaded from the Coursera link, there
are sub-directories for the test and train datasets; for run_analysis.R to work,
it is necessary that all files in both the test and train directories are moved to the main directory, uci_har_dataset)

###Code Explanation###

Part 1: Reads the subject, activity label, and main dataset for the "train" group. Renames the columns in the subject and activity label dataset to subjectID and activityID, respectively. Reads the features dataset, cleans it up a bit, and uses the colnames() fx to set the column names of train_main to the values of the features dataset. cbind() is then used to connect the three train datasets together, creating a complete train_data dataset.

Part 2: Reads the subject, activity label, and main dataset for the "test" group. Uses the previously read features dataset to set the column names of test_main, same as in Part 1. Uses cbind() to connect the three test datasets together, creating a complete test_data dataset.

Part 3: Uses rbind() to connect train_data and test_data into one large final dataset, finaldata.

Part 4: Uses gsub() to rename the values in the activityID column of finaldata to be more "human readable," as specified by activity_labels.txt

Part 5: Uses regular expressions to have finaldata only contain the subjectID, activityID, and columns that contain "[Mm]ean() or std()," in their names.

Part 6: Groups finaldata on subjectID and activityID, and utilized summarize_all to apply the mean() fx to each of the other columns, assigns this to finaldata_2, then prints finaldata_2.

###All columns in finaldata_2 (exluding subjectID and activityID) are the averages 
###of their names. (i.e. tBodyAcc-mean()-X is the average of that variable)
