library(dplyr)
library(readr)
testSet <- read_table2("data/test/X_test.txt", col_names = FALSE)
testLabel <- read_table2("data/test/y_test.txt", col_names = FALSE)
trainingSet <- read_table2("data/train/X_train.txt", col_names = FALSE)
trainingLabel <- read_table2("data/train/y_train.txt", col_names = FALSE)
data_set <- cbind(testLabel, testSet)
data_set1 <- cbind(trainingLabel, trainingSet)
data_set <- rbind(data_set, data_set1)

features <- read_csv("data/features.txt", col_names = FALSE)
x <- function(x){strsplit((x), " ")}
features <- sapply(features, x)
y <- function(y){y[2]}
features <- sapply(features, y)
colnames(data_set) <- features
colnames(data_set)[1] <- "activities"
data_set <- data_set[ ,grep("mean|std|activities", as.character(names(data_set)))]

data_set[, 1] <- sub(pattern = "1", replacement = "WALKING", data_set[, 1])
data_set[, 1] <- sub(pattern = "2", replacement = "WALKING_UPSTAIRS", data_set[, 1])
data_set[, 1] <- sub(pattern = "3", replacement = "WALKING_DOWNSTAIRS", data_set[, 1])
data_set[, 1] <- sub(pattern = "4", replacement = "SITTING", data_set[, 1])
data_set[, 1] <- sub(pattern = "5", replacement = "STANDING", data_set[, 1])
data_set[, 1] <- sub(pattern = "6", replacement = "LAYING", data_set[, 1])

testSubject <- read_table2("data/test/subject_test.txt", col_names = FALSE)
trainSubject <- read_table2("data/train/subject_train.txt", col_names = FALSE)
subject <- rbind(testSubject, trainSubject)
colnames(subject) <- "subject"
data_set <- cbind(subject, data_set)