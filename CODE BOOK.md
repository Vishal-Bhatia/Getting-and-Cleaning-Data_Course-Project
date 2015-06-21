## Preliminary Notes
(1) The final output table is a flat table that shows the averages (over all observations) for all variables for all participants engaging in all activities.
(2) In what follows, I explain each column header, and then give an overview of the variables being measured.

## Column header (from left to right in the final output)
(1) Activity: The activity that the participant is engaging in.
(2) Variable: The variable whose averaged values are being shown; see "Variable name" for details.
(3) Avg.Value.for.Participant.i: This column contains the average values for Participant i for each activity and each variable; there are 30 participants in all. 

## Variable name
(1) The following are the variables that are being studied (with -XYZ is used to denote 3-axial signals in the X, Y, or Z directions):
- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag
(2) Note that the mean() and std() values of these variables are being considered, and averaged.
(3) The prefix "t" denotes a time variable, and "f" denotes frequency domain signals.
(4) The variable names are intuitive; e.g., tBodyAcc-X means a time variable measure body acceleration in the X direction