## This script requires the following packages:
        ##downloader    - http://cran.r-project.org/web/packages/downloader/index.html
        ##dplyr         - http://cran.r-project.org/web/packages/dplyr/index.html

library(dplyr)
library(downloader)

#download the file and extract it into the wd

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
f <- file.path(getwd(), "Dataset.zip")
download.file(url, f, mode = "wb")
unzip ("dataset.zip", exdir = getwd())


## Read in the RAW data into data.tables

X_Test <- read.table("UCI HAR Dataset/test/X_test.txt", sep = "", header = FALSE)
X_Train <- read.table("UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE)

Y_Test <- read.table("UCI HAR Dataset/test/y_test.txt", sep = "", header = FALSE)
Y_Train <- read.table("UCI HAR Dataset/train/y_train.txt", sep = "", header = FALSE)

Subject_Test <- read.table("UCI HAR Dataset/test/subject_test.txt", sep = "", header = FALSE)
Subject_Train <- read.table("UCI HAR Dataset/train/subject_train.txt", sep = "", header = FALSE)

## Bind the data together to create a Features, Activity and Subject table

Features_Data <- rbind(X_Test, X_Train)
Activity_Data <- rbind(Y_Test, Y_Train)
Subject_Data <- rbind(Subject_Test, Subject_Train)

## label the dataset with the appropriate column labels

names(Subject_Data) <-c("Subject_ID")
names(Activity_Data) <- c("Activity_ID")
Names_for_Features_Data <- read.table("UCI HAR DAtaset/features.txt", header = FALSE)
names(Features_Data) <- Names_for_Features_Data[,2]

## Combine all the data in 1 dataset

Samsung_Sensor_Data <- cbind(cbind(Subject_Data, Activity_Data), Features_Data)

## Refine the data by selecting the columns we want to examine

Names_for_Features_Data_Subset <- Names_for_Features_Data[,2][grep("mean\\(\\)|std\\(\\)", Names_for_Features_Data[,2])]

Subset_Names_Full_Selection <- c("Subject_ID", "Activity_ID", as.character(Names_for_Features_Data_Subset))
Samsung_Sensor_Data_Selected <- subset(Samsung_Sensor_Data, select=Subset_Names_Full_Selection)

##  Replacing all the current names with proper logical names
        ## part 1: replacing the activities
as.character(as.integer(Samsung_Sensor_Data_Selected$Activity_ID))
Samsung_Sensor_Data_Selected$Activity_ID <- gsub("1", "Walking", Samsung_Sensor_Data_Selected$Activity_ID)
Samsung_Sensor_Data_Selected$Activity_ID <- gsub("2", "Walking Upstairs", Samsung_Sensor_Data_Selected$Activity_ID)
Samsung_Sensor_Data_Selected$Activity_ID <- gsub("3", "Walking Downstairs", Samsung_Sensor_Data_Selected$Activity_ID)
Samsung_Sensor_Data_Selected$Activity_ID <- gsub("4", "Sitting", Samsung_Sensor_Data_Selected$Activity_ID)
Samsung_Sensor_Data_Selected$Activity_ID <- gsub("5", "Standing", Samsung_Sensor_Data_Selected$Activity_ID)
Samsung_Sensor_Data_Selected$Activity_ID <- gsub("6", "Laying", Samsung_Sensor_Data_Selected$Activity_ID)

        ## part 2: replacing the variable labels
names(Samsung_Sensor_Data_Selected) <- gsub('\\(|\\)',"",names(Samsung_Sensor_Data_Selected), ignore.case = TRUE, perl = TRUE)
names(Samsung_Sensor_Data_Selected) <- gsub("mean", "Mean", names(Samsung_Sensor_Data_Selected))
names(Samsung_Sensor_Data_Selected) <- gsub("std", "STD", names(Samsung_Sensor_Data_Selected))
names(Samsung_Sensor_Data_Selected) <- gsub("Acc", "Acceleration_", names(Samsung_Sensor_Data_Selected))
names(Samsung_Sensor_Data_Selected) <- gsub("^t", "Time_", names(Samsung_Sensor_Data_Selected))
names(Samsung_Sensor_Data_Selected) <- gsub("^f", "Freq_", names(Samsung_Sensor_Data_Selected))
names(Samsung_Sensor_Data_Selected) <- gsub("Gravity", "Gravity_", names(Samsung_Sensor_Data_Selected))
names(Samsung_Sensor_Data_Selected) <- gsub("Gyro", "Circular_Speed_", names(Samsung_Sensor_Data_Selected))
names(Samsung_Sensor_Data_Selected) <- gsub("GyroJerk", "Circular_Acc", names(Samsung_Sensor_Data_Selected))
names(Samsung_Sensor_Data_Selected) <- gsub("Mag", "Magnitude", names(Samsung_Sensor_Data_Selected))
names(Samsung_Sensor_Data_Selected) <- gsub("BodyBody", "Body_", names(Samsung_Sensor_Data_Selected))
names(Samsung_Sensor_Data_Selected) <- gsub("Body", "Body_", names(Samsung_Sensor_Data_Selected))

## Create a second tidy dataset with the averages for every variable for every activity for every subject
Tidy_Data_Average <-aggregate(. ~Subject_ID + Activity_ID, Samsung_Sensor_Data_Selected, mean)

## Order the data first by Subject, then by Activity
Tidy_Data_Average_Ordered <- Tidy_Data_Average[order(Tidy_Data_Average$Subject_ID, Tidy_Data_Average$Activity_ID),]

## Create a .txt file with the data from the tidy dataset
write.table(Tidy_Data_Average_Ordered, file = "Tidy_Data_GACD_Project.txt", row.name=FALSE)