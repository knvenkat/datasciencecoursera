run_analysis_train <- function(){
# this program utilizes following additional packages apart from base-R
# 1: data.table
# 2: dplyr
#
# check for source files, assumption that the files are unzipped and extracted 
# into working directory as-is without moving to an alternate location.

if (!file.exists("UCI HAR Dataset/features.txt")) {
  stop ("Source file: features.txt")
}
if (!file.exists("UCI HAR Dataset/activity_labels.txt")) {
  stop ("Source file: activity_labels.txt")
}
if (!file.exists("UCI HAR Dataset/train/X_train.txt")) {
  stop ("Source file: X_train.txt")
}
if (!file.exists("UCI HAR Dataset/train/y_train.txt")) {
  stop ("Source file: y_train.txt")
}
if (!file.exists("UCI HAR Dataset/train/subject_train.txt")) {
  stop ("Source file: subject_train.txt")
}
# read data
col_names <- fread("UCI HAR Dataset/features.txt")
activity <- fread("UCI HAR Dataset/activity_labels.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
sub_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

# set readable names to the dataset for ease of reference
cnames_desc <- c("id", "desc")
setnames(activity, cnames_desc)
setnames(col_names, cnames_desc)
setnames(y_train, "activitynum")
setnames(sub_train, "subjectnum")
setnames(x_train, gsub("*[(|)|,-]*","", col_names$desc))
# build out the data set
train_data <- bind_cols(sub_train, y_train)
print("Step 1: Completed")
idx <- grep("*mean|std*", col_names$desc)
print("Step 2: Column Index Generated")
# making into data frame for further processing
x_train <- tbl_df(x_train)
 for (i in idx) {
   #print(i)
   train_data <- bind_cols(train_data, x_train[,i])
 }
print("Step 3: train dataset completed")

return(train_data)
}