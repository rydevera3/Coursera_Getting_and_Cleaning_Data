
traindata<-read.table('./UCI HAR Dataset/train/X_train.txt')
trainlabels<-read.table('./UCI HAR Dataset/train/y_train.txt')
trainsubject<-read.table('./UCI HAR Dataset/train/subject_train.txt')

testdata<-read.table('./UCI HAR Dataset/test/X_test.txt')
testlabels<-read.table('./UCI HAR Dataset/test/y_test.txt')
testsubject<-read.table('./UCI HAR Dataset/test/subject_test.txt')

mergedata<-rbind(traindata,testdata)
mergelabels<-rbind(trainlabels,testlabels)
mergesubjects<-rbind(trainsubject,testsubject)

features<-read.table('./UCI HAR Dataset/features.txt')

msdidx<-grep("mean\\(\\)|std\\(\\)",features[,2])
mergedata<-mergedata[,msdidx]

names(mergedata)<-gsub("\\(\\)","",features[msdidx,2])
names(mergedata)<-gsub("mean","Mean",names(mergedata))
names(mergedata)<-gsub("std","Std",names(mergedata))
names(mergedata)<-gsub("-","",names(mergedata))

activities<-read.table('./UCI HAR Dataset/activity_labels.txt')
activities[,2]<-tolower(gsub("_","",activities[,2]))
substr(activities[2,2],8,8)<-toupper(substr(activities[2,2],8,8))
substr(activities[3,2],8,8)<-toupper(substr(activities[3,2],8,8))
activitylabel<-activities[mergelabels[,1],2]
mergelabels[,1]<-activitylabel
names(mergelabels)<-"activity"

names(mergesubjects) <-"subject"
cleanData<-cbind(mergesubjects,mergelabels,mergedata)
dim(cleanData)
write.table(cleanData,"merged_data.txt")

sublength<-length(table(mergesubjects))
actlength<-dim(activities)[1]
collength<-dim(cleanData)[2]

results<-matrix(NA,nrow=sublength*actlength,ncol=collength)
results<-as.data.frame(results)
colnames(results)<-colnames(cleanData)

r<-1
results[,1]=sort(rep(sort(unique(mergesubjects)[,1]),actlength))
results[,2]=rep(activities[,2],sublength)

for(k in 1:sublength){
  for(j in 1:actlength) {
    b1<-k==cleanData$subject
    b2<-activities[j,2]==cleanData$activity
    results[r,3:collength]<-colMeans(cleanData[b1&b2,3:collength])
    r<-r+1
  }
}

write.table(results,"cleanData_with_mean.txt")
      






