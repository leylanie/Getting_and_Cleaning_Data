## Code Book

### Data Source

Source of the original data: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. 

Source of original data description: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

### Data Set Description

The 'UCI HAR Dataset' (Human Activity Recognition Using Smartphones Data Set) 
contains data collected from the accelerometers from the Samsung Galaxy S 
smartphone. The database was built from the recordings of 30 subjects performing 
activities of daily living (ADL) while carrying a waist-mounted smartphone with 
embedded inertial sensors.

#### Data Set Information

> The experiments have been carried out with a group of 30 volunteers within an 
age bracket of 19-48 years. Each person performed six activities (WALKING, 
WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a 
smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer 
and gyroscope, we captured 3-axial linear acceleration and 3-axial angular 
velocity at a constant rate of 50Hz. The experiments have been video-recorded to 
label the data manually. The obtained dataset has been randomly partitioned into 
two sets, where 70% of the volunteers was selected for generating the training 
data and 30% the test data.

> The sensor signals (accelerometer and gyroscope) were pre-processed by applying 
noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 
50% overlap (128 readings/window). The sensor acceleration signal, which has 
gravitational and body motion components, was separated using a Butterworth 
low-pass filter into body acceleration and gravity. The gravitational force is 
assumed to have only low frequency components, therefore a filter with 0.3 Hz 
cutoff frequency was used. From each window, a vector of features was obtained 
by calculating variables from the time and frequency domain. 

> For each record in the dataset it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the 
estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.
- A 561-feature vector with time and frequency domain variables.
- Its activity label.
- An identifier of the subject who carried out the experiment.[1]


#### Data Set Files

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 


From the features_info.txt file:
> These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

> tBodyAcc-XYZ <br>
tGravityAcc-XYZ<br>
tBodyAccJerk-XYZ<br>
tBodyGyro-XYZ<br>
tBodyGyroJerk-XYZ<br>
tBodyAccMag<br>
tGravityAccMag<br>
tBodyAccJerkMag<br>
tBodyGyroMag<br>
tBodyGyroJerkMag<br>
fBodyAcc-XYZ<br>
fBodyAccJerk-XYZ<br>
fBodyGyro-XYZ<br>
fBodyAccMag<br>
fBodyAccJerkMag<br>
fBodyGyroMag<br>
fBodyGyroJerkMag<br>

> The set of variables that were estimated from these signals are: 

> mean(): Mean value<br>
std(): Standard deviation<br>
mad(): Median absolute deviation <br>
max(): Largest value in array<br>
min(): Smallest value in array<br>
sma(): Signal magnitude area<br>
energy(): Energy measure. Sum of the squares divided by the number of values. <br>
iqr(): Interquartile range <br>
entropy(): Signal entropy<br>
arCoeff(): Autorregresion coefficients with Burg order equal to 4<br>
correlation(): correlation coefficient between two signals<br>
maxInds(): index of the frequency component with largest magnitude<br>
meanFreq(): Weighted average of the frequency components to obtain a mean frequency<br>
skewness(): skewness of the frequency domain signal <br>
kurtosis(): kurtosis of the frequency domain signal <br>
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.<br>
angle(): Angle between to vectors.<br>

> Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

> gravityMean<br>
tBodyAccMean<br>
tBodyAccJerkMean<br>
tBodyGyroMean<br>
tBodyGyroJerkMean<br>

## run_analysis.R

The attached R-Script 'run_analysis.R' performs the following steps to clean up the data:

1. Read data files
    2. Read activity labels (dataframe 6 x 2)
    3. Read features (dataframe 561 x 2)
    4. Read training data
        * training data: X_training.txt (7352 x 561)
        * training data activity labels: y_training.txt (7352 x 1)
        * training data subjects id: subject_training.txt (7352 x 1)
    5. Read test data
        * test data: X_test.txt (2947 x 561)       
        * test data activity labels: y_test.txt (2947 x 1)
        * test data subjects id: subject_test.txt (2947 x 1)
2. Merge the training and the test set to a combined dataset. 
    * result: dataframe 10299 x 563
3. Use descriptive activity names from activity label file to name the activities in the data set
    * activity names are: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
4. Use descriptive column names from features file to lable column headings
4. Extract only the measurements on the mean and standard deviation for each measurement.
    * extracts all columns containing either 'mean()' or 'std()' in their column heading.
    * results in a dataframe with 68 columns and 10299 rows
    * All measurements are floating point numbers in the range (-1, 1).
5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
    * 1st column subject id (integer between 1..30)
    * 2nd column activity name
    * column 3 to 68 average of variable for corresponding subject and activity
    * resulting tidy data set contains 180 rows (30 subjects * 6 activities) and 68 columns
6. Save the tidy data set to 'tidy_data.txt'

### References

[1] http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
  
