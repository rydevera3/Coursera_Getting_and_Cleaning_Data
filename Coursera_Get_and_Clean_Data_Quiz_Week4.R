# question 1 

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "acs.csv", method = "curl")
dateDownloaded <- date()
acs <- read.table("acs.csv",sep=",",header=TRUE)
head(acs)
names(acs)
splitNames=strsplit(names(acs),"wgtp")
splitNames[[123]]

# "", "15"


# Question 2
# Remove the commas from the GDP numbers in millions of dollars and average them. 

url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(url, destfile="gdp.csv")
list.files("./data")

gdpData = read.csv("gdp.csv")
str(gdpData)

gdpValues = gdpData$X.3[5:194]
gdpValues = gsub("\\s|,", "", gdpValues)
gdpValues = as.numeric(as.character(gdpValues))


# What is the average? 
mean(gdpValues)
# 377652.4

# Question 3
# what is a regular expression that would allow you to count the number of countries whose name begins with "United"? Assume that the variable with the country names in it is named countryNames. 
# How many countries begin with United?

countryNames = levels(gdpData$X.2)
countryNames

grep("United$",countryNames) # doesn't work
grep("^United",countryNames)
grep("*United",countryNames)
grep("^United",countryNames)

countryNames[grep("^United",countryNames)]

# grep("^United",countryNames), 3


# Question 4

# download gdp data
url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(url, destfile="gdpQuestion4.csv")

gdpData4 = read.csv("gdpQuestion4.csv")
str(gdpData4)

# download education data
url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(url, destfile="educational.csv")

edu = read.csv("educational.csv")
str(edu)
str(gdpData4)
names(edu)

match = grep(tolower("Fiscal year end: June"), tolower(edu$Special.Notes))
x = edu$Special.Notes[match]
length(x)

# 13

# Question 5
# stocks
# How many values were collected in 2012? 
# How many values were collected on Mondays in 2012?

install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 
sampleTimes
class(sampleTimes)

# values collected in 2012
match =sampleTimes[format(sampleTimes, "%Y") == "2012"] 
length(match)

# values collected on Mon 2012
length(match[weekdays(match)=="Monday"])

# 250, 47