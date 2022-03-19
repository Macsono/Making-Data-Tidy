library(dplyr)
x_test <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
x_train <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")

#Merges the training and test sets to create one data set
x_full <- bind_rows(x_train, x_test)
write.csv(x_full, "x.csv", row.names = FALSE) # converts to csv
library(data.table)
header <- fread("getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt",
                header = F)#reads header as a column in R
data <- fread("x.csv", col.names = header$V2) #transfers column names to X dataframe

#merge with y
y_full <- bind_rows(y_train, y_test)
y_full <- y_full %>% rename(y = V1)
df_full <- bind_cols(y_full, data)

newdf <- df_full %>% #selects only variables that have std() and mean() in them
  select(y, contains(c("std()", "mean()")))



newdf["y"][newdf["y"] == 1] <- "WALKING"
newdf["y"][newdf["y"] == 2] <- "WALKING_UPSTAIRS"
newdf["y"][newdf["y"] == 3] <- "WALKING_DOWNSTAIRS"
newdf["y"][newdf["y"] == 4] <- "SITTING"
newdf["y"][newdf["y"] == 5] <- "STANDING"
newdf["y"][newdf["y"] == 6] <- "LAYING"


#tidy data set next

tidy_data <- newdf %>%
  group_by(y) %>%
  summarize_at(vars(`tBodyAcc-std()-X`:`fBodyBodyGyroJerkMag-mean()`),
               mean)
