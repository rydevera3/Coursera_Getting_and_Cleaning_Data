# Downloaded all .csv files into a directory called Coursera Work
# setwd("..../Coursera Work)


setwd("/Users/rdevera/Desktop/Coursera Work")
# Problem 1

r<-read.csv("getdata-data-ss06hid.csv")

log_idx<-(r$ACR==3 & r$AGS==6)
head(which(log_idx))

#125, 238, 262

# Problem 2

library("jpeg")
pic<-readJPEG("getdata-jeff.jpg",native=TRUE)
head(pic)
summary(pic)

quantile(pic,probs=c(30,50,80)/100)

#30%       50%       80% 
#-15259150 -14191406 -10575416

# Problem 3

gdp<-read.csv("gdp.csv")
edu<-read.csv("edu.csv")
View(gdp)

# Notice the ranked rows are rows 5:194
g<-gdp[5:194,]
View(g)

# How many ids match in the GDP and EDU country code columns
gdp_country_code <- g$X
edu_country_code <- edu$CountryCode

matches<-length(which(edu_country_code %in% gdp_country_code))
#189

gdp_decreasing<-gdp_decreasing<-g[sort(g$Gross.domestic.product.2012,decreasing=TRUE),]
# 13 row St. Kitts and Nevis or KNA

#189, St. Kitts and Nevis

# Problem 4

gdp<-read.csv("gdp.csv")
edu<-read.csv("edu.csv")
View(gdp)

# Notice the ranked rows are rows 5:194
g<-gdp[5:194,]
View(g)

mergedData=as.data.frame(merge(g,edu,by.x="X",by.y="CountryCode"))
mergedData$Gross.domestic.product.2012 = as.numeric(as.character(mergedData$Gross.domestic.product.2012))
summary(mergedData[mergedData$Income.Group=="High income: OECD",2])

#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#1.00   12.25   24.50   32.97   45.75  122.00 

mergedData=as.data.frame(merge(g,edu,by.x="X",by.y="CountryCode"))
mergedData$Gross.domestic.product.2012 = as.numeric(as.character(mergedData$Gross.domestic.product.2012))
summary(mergedData[mergedData$Income.Group=="High income: nonOECD",2])

#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#19.00   58.50   94.00   91.91  125.00  161.00 

# 32.97, 91.91



# Problem 5

gdp<-read.csv("gdp.csv")
edu<-read.csv("edu.csv")
g<-gdp[5:194,]

edu_income<-edu[,c("CountryCode","Income.Group")]
edu_lower_middle_income<-edu_income[edu_income$Income.Group=="Lower middle income",]

# Top 38 nations for gdp
g_top<-g[1:38,]

length(which(g_top$X %in% edu_lower_middle_income$CountryCode))
# 5










