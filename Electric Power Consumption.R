# First estimate the size of the dataframe.
# 2m rows and 9 columns = 1.8m cells of 8 bytes each

2000000*9*8

# i.e 144Mb needed

setwd("/Users/esteebie/Documents/DATA/Courses/4. JHU/4. Exploratory Data Analysis/1. Course Project 1 - power consumption")
consump <- read.table("household_power_consumption.txt",header=T,sep=";",na.strings="?")
today <- consump[consump$Date %in% c("1/2/2007","2/2/2007"),]
today <- droplevels(today)
rm(consump)
today$Date <- strptime(today$Date, "%d/%m/%Y")
today$Time <- strptime(today$Time, "%H:%M:%S")
today$datetime <- as.POSIXct(paste(today$Date, today$Time), format="%d/%m/%Y %H:%M:%S")

# PLOT 1
png(filename="plot1.png", width=480, height = 480)
hist(today$Global_active_power, breaks=15, xlab= "Global Active Power (kilowatts)", main = "Global Active Power", col="red")
dev.off()

# PLOT 2
png(filename="plot2.png", width=480, height = 480)
plot(today$datetime,today$Global_active_power, xlab=NA, ylab="Global Active Power (kilowatts)", type="l")
dev.off()

# PLOT 3
png(filename="plot3.png", width=480, height = 480)
plot(today$datetime,today$Sub_metering_1, type="l", xlab=NA, ylab="Energy sub metering")
lines(today$datetime,today$Sub_metering_2, type="l", col="red")
lines(today$datetime,today$Sub_metering_3, type="l", col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1)
dev.off()

# PLOT 4
png(filename="plot4.png", width=480, height = 480)
par(mfrow=c(2,2))
plot(today$datetime,today$Global_active_power, xlab=NA, ylab="Global Active Power", type="l")
plot(today$datetime,today$Voltage, type="l", xlab="datetime",ylab="Voltage")
plot(today$datetime,today$Sub_metering_1, type="l", xlab=NA, ylab="Energy sub metering")
lines(today$datetime,today$Sub_metering_2, type="l", col="red")
lines(today$datetime,today$Sub_metering_3, type="l", col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1)
plot(today$datetime,today$Global_reactive_power, type="l",xlab="datetime",ylab="Global_reactive_power")
dev.off()
