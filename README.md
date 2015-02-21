Getting and Cleaning Data (getdata-011)
===================

Logic for this assignment is as follows. Initial step loads the training data and cleans as per the requirement and second step performs same activities as the first excpt the dataset is related to testing. Both datasets are then integrated into a single large table before grouping and performed and output is generated based on logic and finally exported to a local text file.

## Program has been split into three parts as follows
1. run_analysis_train(): Function that reads, cleans and populates the data for train dataset
2. run_analysis_test(): Function that reads, cleans and populates the data for test dataset
3. run_analysis: Main program that reads the above two functions and processes the final dataset

##Following is the sequence of action performed

### Load Training Data
1. Check for file in location and propmt error if any issue
2. Load training data X_train, Y_train, activity_labels
3. Cleanup activity labels by removing unwanted characters and assign as column names 
4. Bind by columns the subjects, activity and training data
5. Create index to match "std" or "mean" and clean up data frame to match only required columns

### Load Test Data
1. Perform steps as before for the new set of files

### Merging data
1. Bind both train and test data by rows
2. Merge the consolidated data with activity labels and remove the column with activity number
3. Group by the dataset by subject and activity name
4. Apply summarise_each on the grouped data to calculate mean on all variables
5. Export the final data

## Assumptions: Matching columns with mean or standard deviation was a simple text based search for the key words. Positions and cases are NOT considered during the checking process (e.g. "Mean" is not checked whereas "mean" is checked).
