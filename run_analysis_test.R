run_analysis_test <- function(){
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
if (!file.exists("UCI HAR Dataset/test/X_test.txt")) {
  stop ("Source file: X_test.txt")
}
if (!file.exists("UCI HAR Dataset/test/y_test.txt")) {
  stop ("Source file: y_test.txt")
}
if (!file.exists("UCI HAR Dataset/test/subject_test.txt")) {
  stop ("Source file: subject_test.txt")
}
# read data
col_names <- fread("UCI HAR Dataset/features.txt")
activity <- fread("UCI HAR Dataset/activity_labels.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
sub_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# set readable names to the dataset for ease of reference
cnames_desc <- c("id", "desc")
setnames(activity, cnames_desc)
setnames(col_names, cnames_desc)
setnames(y_test, "activitynum")
setnames(sub_test, "subjectnum")
setnames(x_test, gsub("*[(|)|,-]*","", col_names$desc))
# build out the data set
test_data <- bind_cols(sub_test, y_test)
print("Step 1: Completed")
idx <- grep("*mean|std*", col_names$desc)
print("Step 2: Column Index Generated")
# making into data frame for further processing
x_test <- tbl_df(x_test)
 for (i in idx) {
   #print(i)
   test_data <- bind_cols(test_data, x_test[,i])
 }
print("Step 3: test dataset completed")

return(test_data)
}