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


########## creating PLOT 3.PNG ##################################################
# this is graph that has y= global active power nd x= days from thurs to saturday
# grab the data for the dates were are only interested in 
d <- data %>% filter(Date %in% c("1/2/2007","2/2/2007"))
# convert the sub_meter fields to numeric otherwise will get an error 
d <- d %>% dplyr::mutate_each(as.numeric, Sub_metering_1=Sub_metering_1,Sub_metering_2=Sub_metering_2,Sub_metering_3=Sub_metering_3 )
# change the time field character to a POSIXLt 
d$Time <- strptime(paste(d$Date,d$Time,sep = " "), "%d/%m/%Y %H:%M:%S")

png("plot3.png", width=480, height=480)
plot(x=d$Time ,y=d$Sub_metering_1, type = "l",ylab="Energy sub metering",xlab="")
lines(x=d$Time,y=d$Sub_metering_2, col ="red")
lines(x=d$Time,y=d$Sub_metering_3, col ="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),col = c("black", "red","blue"),lwd = 1)
dev.off()