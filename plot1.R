library(dplyr)


#download file and reading directly into a table
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp,"household_power_consumption.txt"),sep = ";")
unlink(temp)

#wd <- getwd()
#reading directly from working directory if dont want to do above 
#data <- read.table("./exdata_data_household_power_consumption/household_power_consumption.txt",sep=";", header = TRUE)

# removing any na in the data
data <- na.omit(data)

########## creating PLOT 1.PNG ##################################################
## This plot has x= "Global Active Power (kilowatts)" and Y= "Frequency" , title ="Global Active Power"
# get the selected dates
## make Global Active Power Variable numeric as it is generating an error as it is char

d <- data %>% filter(Date %in% c("1/2/2007","2/2/2007"))
d <- d %>% transform(Global_active_power=as.numeric(Global_active_power))

png("plot1.png", width=480, height=480)
hist(d$Global_active_power
     ,main="Global Active Power"
     ,xlab="Global Active Power (kilowatts)"
     ,col="red"
     )
dev.off()