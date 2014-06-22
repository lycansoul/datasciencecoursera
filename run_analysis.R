#step1 read and merge data
X_test <- read.table("./gcd/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./gcd/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./gcd/UCI HAR Dataset/test/subject_test.txt")
X_train <- read.table("./gcd/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./gcd/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./gcd/UCI HAR Dataset/train/subject_train.txt")
cbtest <- cbind(X_test,y_test,subject_test)
cbtrain <- cbind(X_train,y_train,subject_train)
Tdata <- rbind(cbtest,cbtrain)

#step2 extract
msc <- c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,
345:350,424:429,503:504,516:517,529:530,542:543,562:563)
Tdata2 <- Tdata[,msc]

#step3 name the activities
Tdata2[,67] <- as.factor(Tdata2[,67])
levels(Tdata2[,67]) <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")

#step4  descriptive variable names
features <- read.table("./gcd/UCI HAR Dataset/features.txt")
featuresnames <- features[,2]
names(Tdata2) <- featuresnames[msc]
names(Tdata2)[67] <- "label"
names(Tdata2)[68] <- "subject"

#step5 tidy data
MTdata <- melt(Tdata2,id=c("label","subject"),measures.vars=c(names(Tdata2)))
CTdata <- dcast(MTdata,label+subject~variable,mean)