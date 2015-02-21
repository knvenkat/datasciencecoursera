# Coursera: getdata-011
# Pacahges required: dplyr, data.table
# Two functions created to read and populate data tables independently
# Filtering out unwanted columns in the main function in order to keep data 
# transferred minimal.
#
# Main program processes and calculates the required metrics
#
# Read primary datasets
t1 <- run_analysis_train()
t2 <- run_analysis_test()
# Get activity labels
activity <- fread("UCI HAR Dataset/activity_labels.txt")
colnames(activity) <- c("id", "desc")
# Merging data into single dataset and including the activity description
t3 <- bind_rows(t1, t2)
t3 <- merge(t3, activity, by.x = "activitynum", by.y = "id")
# removing unwanted column
t3 <- select(t3, -activitynum)
# grouping the data
t4 <- group_by(t3, subjectnum, desc, add=TRUE)
final_output <- summarise_each(t4, funs(mean))
# exporting to file
write.table(t7, file="getdata-011.txt", sep=" ", col.names=TRUE, row.names=FALSE)

