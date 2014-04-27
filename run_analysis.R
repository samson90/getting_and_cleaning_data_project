data_folder <- "UCI HAR Dataset"

if (file.exists(data_folder)){
    test_file <- "UCI HAR Dataset/test/X_test.txt"
    train_file <- "UCI HAR Dataset/train/X_train.txt"
    features_file <- "UCI HAR Dataset/features.txt" 
    
    ## read in the test and train datasets and merge them
    test_data <- read.table(test_file)
    train_data <- read.table(train_file)
    total_data <- rbind(train_data, test_data)
    
    ## assign the column names to the data set
    features <- read.table(features_file)[,2]
    colnames(total_data) <- features
    
    ## get the mean and std for each measurement
    mean_std_features <- features[grepl("mean()", features, fixed=TRUE) |
                                  grepl("std()", features, fixed=TRUE)]
    mean_std_data <- total_data[as.vector(mean_std_features)]
    num_measurements <- ncol(mean_std_data)
    
    ## add the activities to the dataset
    test_activity_file <- "UCI HAR Dataset/test/Y_test.txt"
    train_activity_file <- "UCI HAR Dataset/train/Y_train.txt"
    test_activity <- scan(test_activity_file, integer())
    train_activity <- scan(train_activity_file, integer())
    total_activity <- c(train_activity, test_activity)
    mean_std_data["Activity"] <- total_activity
    
    ## add the subject to the dataset
    test_subject_file <- "UCI HAR Dataset/test/subject_test.txt"
    train_subject_file <- "UCI HAR Dataset/train/subject_train.txt"
    test_subject <- scan(test_subject_file, integer())
    train_subject <- scan(train_subject_file, integer())
    total_subject <- c(train_subject, test_subject)
    mean_std_data["Subject"] <- total_subject

    tidy_data <- NULL
    tidy_data <- rbind(tidy_data, colMeans(mean_std_data[mean_std_data$Activity == 1,][1:num_measurements]))
    tidy_data <- rbind(tidy_data, colMeans(mean_std_data[mean_std_data$Activity == 2,][1:num_measurements]))
    tidy_data <- rbind(tidy_data, colMeans(mean_std_data[mean_std_data$Activity == 3,][1:num_measurements]))
    tidy_data <- rbind(tidy_data, colMeans(mean_std_data[mean_std_data$Activity == 4,][1:num_measurements]))
    tidy_data <- rbind(tidy_data, colMeans(mean_std_data[mean_std_data$Activity == 5,][1:num_measurements]))
    tidy_data <- rbind(tidy_data, colMeans(mean_std_data[mean_std_data$Activity == 6,][1:num_measurements]))
    for (i in 1:30){
        tidy_data <- rbind(tidy_data, colMeans(mean_std_data[mean_std_data$Subject == i,][1:num_measurements]))
    }
    colnames(tidy_data) <- colnames(mean_std_data[1:num_measurements])
    
    print(ncol(tidy_data))
    print(nrow(tidy_data))
    print(rownames(tidy_data))
    
    write.table(tidy_data, "tidy_data.txt")
    
} else{
    print("UCI HAR Dataset does not exist in working directory")
}