## Getting_and_Cleaning_Data

This repository contains the following files:

1. run_analysis.R
2. CodeBook.md
3. README.md
4. tiny_data.txt

### run_analysis.R

The 'run_analysis.R' R-script transform the 'UCI HAR Dataset' raw data set into a tidy data set tidy_data.txt, which contains the average measurement of each of the variables for each subject. 

To run the run_analysis.R script please make sure to first download and unzip the data source (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) into your current R working directory.

With source("run_analysis.R") you can then run the R-script in your woking directory.
It will read the dataset and write the cleaned dataset tidy_data.txt to your working directory.
    
### CodeBook.md

The codebook.md file describes the variables, the data, and data transformations work that were performed to clean up the data.

### tiny_data.txt

tiny_data.txt contains the tab-separated cleanded data set produced by run_analysis.R