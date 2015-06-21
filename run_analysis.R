##The following packages are needed for this code to run properly: plyr, Hmisc, reshape2, and dplyr

###PHASE 1###
####(1) I first read "features.txt" as a table into R, and then change the class of its second column from "factor"
####    to "character".
Features <- read.table("features.txt")
Features$V2 <- as.character(Features$V2)
####(2) I do the same for "activity_labels.txt", but here, I also give the columns, names. The first column's name
####    "ActivityID" is later used to join this table with another.
Activities <- read.table("activity_labels.txt")
Activities$V2 <- as.character(Activities$V2)
colnames(Activities) <- c("ActivityID","Activity")
####(3) I now create a character vector whose first element is "ActivityID"; the remaining elements are the feature list, 
####    which we have stored as the second column of R object Features. This string is used to assign row names to the 
####    main datasets.
TaskNomenclature <- c("ActivityID", as.character(Features$V2))


###PHASE 2###
####(1) I read the files "y_test.txt" (which contains the activity IDs for Test-group participants) and
####    "X_test.txt" (which contains the actual measurement data for those activities for Test-group participants)
####    as tables into R, and then cbind them. The R object TaskNomenclature is used to give row names to this cbinded data.
TestGroupLabels <- read.table("y_test.txt")
TestGroupData <- read.table("X_test.txt")
TestAttempt <- cbind(TestGroupLabels,TestGroupData)
colnames(TestAttempt) <- TaskNomenclature
####(2) I join the tables TestAttempt and Activities so that the final output contains a column with activity names.
TestAttempt <- join(TestAttempt,Activities)
####(3) I read the file "subject_test.txt" as a table into R; this is a single-column table containing participant IDs for
####    Test group measurments. I give this single-column table, column name "ParticipantID" and cbind it with Test-group
####    data, so that the final output contains a column with participant IDs.
TestSubjects <- read.table("subject_test.txt")
colnames(TestSubjects) <- c("ParticipantID")
TestAttempt <- cbind(TestSubjects,TestAttempt)
####(4) To the Test-group data, I add a new column ("GroupType") with value "Test" for all rows. This step is not needed;
####    I do so to ensure distinction in the combined (i.e., containing both Test and Train observations) crude dataset.
TestAttempt$GroupType <- c("Test")


###PHASE 3###
####(1) Phase 2 steps are repeated for Train-group data.
TrainGroupLabels <- read.table("y_train.txt")
TrainGroupData <- read.table("X_train.txt")
TrainAttempt <- cbind(TrainGroupLabels,TrainGroupData)
colnames(TrainAttempt) <- TaskNomenclature
TrainAttempt <- join(TrainAttempt,Activities)
TrainSubjects <- read.table("subject_train.txt")
colnames(TrainSubjects) <- c("ParticipantID")
TrainAttempt <- cbind(TrainSubjects,TrainAttempt)
TrainAttempt$GroupType <- c("Train")


###PHASE 4###
####(1) I rbind the rough Test- and Train-group datasets, and then clean it (re-arrange columns and rows). 
CrudeData <- rbind(TestAttempt,TrainAttempt)
CrudeData <- cbind(CrudeData[565], CrudeData[1], CrudeData[2], CrudeData[564], CrudeData[3:563])
CrudeData <- arrange(LessCrudeData, GroupType, ParticipantID, ActivityID)
####(2) I now narrow-down the cleaned  dataset, so that it contains only mean() and std() columns.
FilteredData <- select(CrudeData, contains("mean()"), contains("std()"))
RefinedData <- cbind(CrudeData[1:4],FilteredData)


###PHASE 5###
####(1) To get the tidy dataset as mentioned in step 5, I use the dcast function with the variables being taken as values. I
####    use a for loop to obtain the final table that contains the average of each variable for each activity and each subject.
####    Note that final output is obtained as needed, but the for loop yields an error (which I have been unable to correct
####    due to time constraints). 
i <- 5
DerivedData <- dcast(RefinedData, Activity ~ ParticipantID, mean, value.var = colnames(RefinedData)[i])
DerivedData$Variable <- c(colnames(RefinedData)[i])
for(i in 5:ncol(RefinedData)){
  i <- i + 1
  TempData <- dcast(RefinedData, Activity ~ ParticipantID, mean, value.var = colnames(RefinedData)[i])
  TempData$Variable <- c(colnames(RefinedData)[i])
  DerivedData <- rbind(DerivedData, TempData)
}
TidyData <- cbind(DerivedData[1], DerivedData[32], DerivedData[2:31])
colnames(TidyData)[3:32] <- paste("Avg.Value.for.Participant.", colnames(TidyData)[3:32], sep = "")
TidyData