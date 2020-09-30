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

########## ConversionS ############################################
# getting data that we only need 
d <- data %>% filter(Date %in% c("1/2/2007","2/2/2007"))
# convert the global acive power to numeric otherwise will get an error 
d <- d %>% transform(Global_active_power=as.numeric(Global_active_power))
# change the time field character to a POSIXLt 
d$Time <- strptime(paste(d$Date,d$Time,sep = " "), "%d/%m/%Y %H:%M:%S")
d <- d %>% dplyr::mutate_each(as.numeric
              , Sub_metering_1=Sub_metering_1
              ,Sub_metering_2=Sub_metering_2
              ,Sub_metering_3=Sub_metering_3
              ,Voltage=Voltage
              ,Global_reactive_power=Global_reactive_power)



png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

#plot 2
plot(x=d$Time,y=d$Global_active_power, xlab="" ,ylab="Global Active Power (kilowatts)",type="l")

# pot 4 voltage
plot(x=d$Time,y=d$Voltage, xlab="datetime" ,ylab="Voltage",type="l")

#plot 3
plot(x=d$Time ,y=d$Sub_metering_1, type = "l",ylab="Energy sub metering",xlab="")
lines(x=d$Time,y=d$Sub_metering_2, col ="red")
lines(x=d$Time,y=d$Sub_metering_3, col ="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),col = c("black", "red","blue"),lwd = 1)

#plot 4 global reactive power
plot(x=d$Time, y=d$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()