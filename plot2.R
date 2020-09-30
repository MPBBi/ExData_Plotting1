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


########## creating PLOT 2.PNG ##################################################
# this is graph that has y= global active power nd x= days from thurs to saturday
# grab the data for the dates were are only interested in 
d <- data %>% filter(Date %in% c("1/2/2007","2/2/2007"))
# convert the global acive power to numeric otherwise will get an error 
d <- d %>% transform(Global_active_power=as.numeric(Global_active_power))
# change the time field character to a POSIXLt 
d$Time <- strptime(paste(d$Date,d$Time,sep = " "), "%d/%m/%Y %H:%M:%S")

png("plot2.png", width=480, height=480)
plot(x=d$Time,y=d$Global_active_power, xlab="" ,ylab="Global Active Power (kilowatts)",type="l")
dev.off()