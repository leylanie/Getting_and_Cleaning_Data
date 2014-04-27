# read labels 

activity <- read.table('UCI HAR Dataset/activity_labels.txt', h=F, 
                       stringsAsFactors=F)
features <- read.table('UCI HAR Dataset/features.txt', h=F, stringsAsFactors=F)

# read data

test_data      <- read.table('UCI HAR Dataset/test/X_test.txt', header=F, 
                             stringsAsFactors=F)
test_labels    <- read.table('UCI HAR Dataset/test/y_test.txt', header=F, 
                             stringsAsFactors=F)
test_subjects  <- read.table('UCI HAR Dataset/test/subject_test.txt', header=F, 
                             stringsAsFactors=F)

train_data     <- read.table('UCI HAR Dataset/train/X_train.txt', header=F, 
                             stringsAsFactors=F)
train_labels   <- read.table('UCI HAR Dataset/train/y_train.txt', header=F, 
                             stringsAsFactors=F)
train_subjects <- read.table('UCI HAR Dataset/train/subject_train.txt', header=F, 
                             stringsAsFactors=F)

# 1. Merges the training and the test sets to create one data set.
# 2. Uses descriptive activity names to name the activities in the data set
# 3. Appropriately labels the data set with descriptive activity names. 

subjects   <- rbind(train_subjects, test_subjects)
labels     <- rbind(train_labels, test_labels)
labels$id  <- 1:nrow(labels)

activity_labels <- merge(labels, activity, by='V1')
activity_labels <- activity_labels[order(activity_labels$id), c(1,3)]

data = cbind(subjects, activity_labels$V2, rbind(train_data, test_data))

# 4. Extracts only the measurements on the mean and standard deviation for each
#    measurement. 

cols <- grep(pattern='mean()|std()', features[,2])
cols <- cols[-c(47:49,56:58,65:67,70,73,76,79)]

data <- data[, c(1,2,cols + 2)]

colnames(data) <- c('subject', 'activity', features[cols,2])

# 5. Creates a second, independent tidy data set with the average of each  
#    variable for each activity and each subject.

tidy_data <- data.frame(t(rep(NA,67)), stringsAsFactors=F)
tidy_data <- tidy_data[-1,]

for(i in unique(sort(subjects$V1))){
  for(j in unique(activity_labels$V2)){
    
    sub     <- subset(data, subset=(data$subject==i & data$activity==j))
    colmean <- colMeans(sub[,-c(1:2)])
    
    tidy_data <- rbind(tidy_data, c(i, colmean))
  }
}

tidy_data <- cbind(tidy_data[,1], rep(unique(activity_labels$V2),30), 
                   tidy_data[2:67])

colnames(tidy_data) <- colnames(data)

write.table(tidy_data, file='tidy_data.txt', col.names=T, row.names=F, quote=F, 
            sep='\t')
