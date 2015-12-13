Sys.setlocale("LC_ALL", "English")

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"),header=TRUE,na.strings = "NA",sep = ";")
unlink(temp)

filtereddata <- data[(as.Date(data$Date, format = "%d/%m/%Y") == "2007-02-01" | as.Date(data$Date, format = "%d/%m/%Y") == "2007-02-02"),]
filtereddata$Date <- as.Date(filtereddata$Date, format = "%d/%m/%Y") 
filtereddata$Global_active_power <- as.numeric(as.character(filtereddata$Global_active_power))
filtereddata$Global_reactive_power <- as.numeric(as.character(filtereddata$Global_reactive_power))
filtereddata$Voltage <- as.numeric(as.character(filtereddata$Voltage))
filtereddata$Sub_metering_1 <- as.numeric(as.character(filtereddata$Sub_metering_1))
filtereddata$Sub_metering_2 <- as.numeric(as.character(filtereddata$Sub_metering_2))
filtereddata$Sub_metering_3 <- as.numeric(as.character(filtereddata$Sub_metering_3))
filtereddata$DateTime <- with(filtereddata, as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S", tz = "GMT"))


png(filename="plot4.png")
par(mfrow = c(2,2))
with(filtereddata,plot(DateTime,Global_active_power, type = "l", ylab = "Global Active Power", xlab =" "))
with(filtereddata,plot(DateTime,Voltage, type = "l", ylab = "Voltage", xlab="datetime"))
with(filtereddata,{
  plot(DateTime,Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab =" ")
  points(DateTime,Sub_metering_2, type='l', col="red")
  points(DateTime,Sub_metering_3, type='l', col="blue")
}
)
legend("topright", pch = "_", col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
with(filtereddata,plot(DateTime,Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab="datetime"))
dev.off()
