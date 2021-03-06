# Introduction
This repository contains the final project of the [Getting and Cleaning Data course](https://www.coursera.org/learn/data-cleaning) offered by Johns Hopkins University on the Coursera platform.
The objective of the project is to treat a set of files collected from the [accelerometers from the Samsung Galaxy S smartphone](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) to result in a single data set with the average and standard deviation records for each of the identified characteristics.
Below are paraphrased the 5 steps required for the project:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Files
The repository contains 4 files:
1. run_analysis.R: The script that contains all the functions for collecting, processing data and generating the file tidy_data.txt
2. codeBook.md: Description of variables and data cleaning performed by the file run_analysis.R
3. README.md: Project description file
4. tidy_data.txt: the file generated by running the run_analysis.R script. It can be deleted (it will be created again in the execution of the script).

# run_analysis.R
The file starts loading the packages that will be used in the analysis (see requirements), from there it has a sequence of functions:
1. `download_data()`: Checks if the data is in the repository (that is, if there is a visible folder called "UCI HAR Dataset"), if not, the data will be downloaded and the new folder will be created with the files.

2. `build_tibble(folder_path, features_names, features_indexes, set)`: Since there is a great similarity in the process performed to clear training and test data, a function has been created that performs this process to avoid duplication. This function is called by the `run_analysis()` function and has four arguments:
- folder_path: Path to the training folder ("UCI HAR Dataset / train /"), or to the test folder ("UCI HAR Dataset / test /")
- features_names: Names of variables to be captured
- features_indexes: Variable indexes that will be captured
- set: "train" or "test"
The function first reads the file with all the collected data ("X_train" or "X_test", depending on the value of the set parameter) and extracts the columns with the necessary information and their respective names. In sequence, the activity and subject status values are read to be joined in a single set of training or test data.

3. `run_analysis()`: It is the function that will return the required data set up to step 4. It starts by calling the `download_data()` function and then reads the features.txt file to identify which columns and indexes contain the words "mean" or "std ", passing these vectors parameter to the` build_tibble() `function to create the training and test tibbles.
After creating these two data sets, the script joins them and updates the activity status values of integers for their string references (via the file "activity_labels.txt.txt). The script calls this function for the "data" object, which in turn will store the requested data set.

4. `tidy_data(data)`: Take as a parameter the dataset created by `run_analysis()` and transform it into a tidy dataset following the one required by step 5, that is, it groups the data by unique subject and status tuples, taking the averages for the values of each one other attributes. The new_data object will store this new dataset and then it will be passed to a txt file ("tidy_data.txt"), ending the script.

# Run script
1. Download run_analysis.R (or clone the repository, but you will only need this script)
2. Change your working directory to the folder that downloaded the script using the `setwd()` function.
3. Type in your R terminal `source('run_analysis.R')` and a data variable will be generated with the required one up to step 4, in addition to the new file tidy_data.txt which is also stored in the variable new_data. 

# Requirements
The packages plyr (for use of the mapvalues function), dplyr, stats and stringr were used. To run the script you must download them from [CRAN](https://cran.r-project.org/). One way is to type the lines below into your R terminal.
```R 
install.packages("plyr")
install.packages("dplyr")
install.packages("stats")
install.packages("stringr")
```
