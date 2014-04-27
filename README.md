# Creating a Tidy Dataset

This project includes a file run_analysis.R which takes the source files and combines and processes them to create a tidy dataset.

#### Source File Types

There are three types of files:
1. A "subject" file that identifies which subject the results are from. There are a total of 30 subjects.
2. A "y" file that identifies the test activity the subject was undertaking when readings were made. There are 6 activities.
3. An "X" file that contains the measurements

There are two datasets that make up the source data: a train set and a test set. Each of these datasets contain each of the three file types listed above.

#### Output File Requirements

The output file should contain a combination of records from the train and test datasets, but only a subset of the columns. The columns requested were those that are measurements of the mean and standard deviation for the core measurements. The exact wording was "Extracts only the measurements on the mean and standard deviation for each measurement." There were aggregate statistics for core measurements that included mean, standard deviation, min, max, and others with column names like "fBodyBodyGyroJerkMag-mean()" and "fBodyBodyGyroJerkMag-std()" while there were also column names like "fBodyBodyGyroMag-meanFreq(). Our interpretation was that the first example was an aggregate statistic of a core measurement where the second type was a core measurement itself, so only the first type were included. The way they were differentiated was that those that ended in "mean()" or "std()" were included, but those with "mean" or "std" elsewhere in the field name were excluded.

#### Data Process

The import and cleaning process follows this steps:

1. Read the features.txt file to gather column numbers and names
2. Tidy up the column names by removing underscores, parentheses, dashes, and capital letters
3. Read the train files and subset the columns of data desired
4. Read the test files and subset the columns of data desired
5. Combine subject, y- and x- files by column for train and test datasets
6. Combine train and test datasets by row
7. Update the activity column from the y- file from numbers to descriptive names
8. Calculate the average of each measurement for each combination fo subject and activity
9. Save the dataset to a text file

#### Notes on Methodology

The grep and gsub functions were used to parse the features.txt file contents to identify the desired columns. These results were then used to subset the appropriate columns from the X- file and apply column names to the subset columns.

The cbind and rbind functions were used to combine the six source files into one large dataset.

Inserting activity descriptions was done using brute-force substition. I tried for many hours to make a more elegant solution work using factors, but while I could get a factor with the appropriate levels from the activity labels file, I could not figure out how to make the replacement in the combined dataset. There are severe limitations to this bruteforce approach since any changes in the number or description of activities would require manual manipulation of the script rather than simply updating the activity labels file.

Calculation of the means of the means and standard deviations was done using the reshape2 package and the melt and dcast functions.


 

