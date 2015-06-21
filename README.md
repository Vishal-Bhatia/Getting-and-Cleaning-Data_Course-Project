## Preliminary Steps
The following packages are needed for this code to run properly: plyr, Hmisc, reshape2, and dplyr
For readability, I have divided my code into 4 phases.

## PHASE 1
(1) I first read "features.txt" as a table into R, and then change the class of its second column from "factor" to "character".
(2) I do the same for "activity_labels.txt", but here, I also give the columns, names. The first column's name is "ActivityID" and this is later used to join this table with another.
(3) I now create a character vector whose first element is "ActivityID"; the remaining elements are the feature list, which we have stored as the second column of R object Features. This string is used to assign row names to the main datasets.

## PHASE 2
(1) I read the files "y_test.txt" (which contains the activity IDs for Test-group participants) and "X_test.txt" (which contains the actual measurement data for those activities for Test-group participants) as tables into R.
(2) I then cbind the two tables. The R object TaskNomenclature is used to give row names to this cbinded data.
(3) I join the cbinded table and Activities so that the final output contains a column with activity names.
(4) I read the file "subject_test.txt" as a table into R; this is a single-column table containing participant IDs for Test group measurments. I give this single-column table, column name "ParticipantID".
(5) I cbind this single-column table with Test-group data, so that the final output contains a column with participant IDs.
(5) To the Test-group data, I add a new column ("GroupType") with value "Test" for all rows. This step is not needed; I do so to ensure distinction in the combined (i.e., containing both Test and Train observations) crude dataset.

## PHASE 3
(1) Phase 2 steps are repeated for Train-group data.

## PHASE 4
(1) I rbind the rough Test- and Train-group datasets, and then clean it (re-arrange columns and rows for viewability). 
(2) I now narrow-down the cleaned  dataset, so that it contains only mean() and std() columns.

## PHASE 5
(1) To get the tidy dataset as mentioned in step 5, I use the dcast function with the variables being taken as values.
(2) I use a for loop to obtain the final table that contains the average of each variable for each activity and each subject.
(3) Note that final output is obtained as needed, but the for loop yields an error (which I have been unable to correct due to time constraints). Again, this causes no issues though.