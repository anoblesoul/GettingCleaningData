##########################
# FILE CONTENT DESCRIPTION
##########################

#subject_train and subject_test identify the individual
#y_train and y_test identify the 6 test activities
#x_train and x_test provide the results 

##########################
# GATHER MEAN AND STD SUBSET COLUMNS AND NAMES
##########################
filename="./data/UCI HAR Dataset/features.txt"
features=read.table(file=filename, header=F)

cols=sort(c(grep("mean()",features$V2, fixed=T),grep("std()",features$V2, fixed=T)))
col_names = features$V2[cols]

#tidy up column names
col_names = gsub("_","",col_names)
col_names = gsub("()","",col_names, fixed=T)
col_names = gsub("-","",col_names)
col_names = tolower(col_names)

##########################
# READ TRAIN FILES
##########################

#read raw subject_train file and assign column name
filename="./data/UCI HAR Dataset/train/subject_train.txt"
subject_train=read.table(file=filename, header=F)
colnames(subject_train) = "subject"

#read raw X_train file
filename="./data/UCI HAR Dataset/train/X_train.txt"
x_train=read.table(file=filename, header=F)

#subset x_train file to only mean() and std() columns and assign column names
x_train_sub = x_train[,cols]
colnames(x_train_sub) = col_names

#read raw y_train file
filename="./data/UCI HAR Dataset/train/y_train.txt"
y_train=read.table(file=filename, header=F)
colnames(y_train) = "activity"

##########################
# READ TEST FILES
##########################

#read raw subject_test file
filename="./data/UCI HAR Dataset/test/subject_test.txt"
subject_test=read.table(file=filename, header=F)
colnames(subject_test) = "subject"

#read raw X_test file
filename="./data/UCI HAR Dataset/test/X_test.txt"
x_test=read.table(file=filename, header=F)

#subset x_test file to only mean() and std() columns and assign column names
x_test_sub = x_test[,cols]
colnames(x_test_sub) = col_names

#read raw y_test file
filename="./data/UCI HAR Dataset/test/y_test.txt"
y_test=read.table(file=filename, header=F)
colnames(y_test) = "activity"

##########################
# COMBINE TEST AND TRAIN FILES
##########################

comb_train = cbind(subject_train, y_train, x_train_sub)
comb_test = cbind(subject_test, y_test, x_test_sub)
comb_all = rbind(comb_test, comb_train)

##########################
# INSERT ACTIVITY DESCRIPTIONS
##########################

comb_all$activity[comb_all$activity==1] = "WALKING"
comb_all$activity[comb_all$activity==2] = "WALKING_UPSTAIRS"
comb_all$activity[comb_all$activity==3] = "WALKING_DOWNSTAIRS"
comb_all$activity[comb_all$activity==4] = "SITTING"
comb_all$activity[comb_all$activity==5] = "STANDING"
comb_all$activity[comb_all$activity==6] = "LAYING"

##########################
# CALCULATE AVERAGE OF EACH VARIABLE FOR EACH SUBJECT AND ACTIVITY
##########################

library(reshape2)

#melting datasets
comb_all_melt=melt(comb_all,id=c("subject","activity"),measure.vars=col_names)
comb_cast = dcast(comb_all_melt, subject + activity ~ variable, mean)

##########################
# SAVE TIDY DATASET
##########################
filenamew="./data/UCI HAR Dataset/tidy_dataset.csv"
write.table(comb_cast,file=filenamew, sep=",", row.names = F, col.names = T)

