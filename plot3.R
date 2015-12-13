Sys.setlocale("LC_ALL", "English")

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"),header=TRUE,na.strings = "NA",sep = ";")
unlink(temp)

filtereddata <- data[(as.Date(data$Date, format = "%d/%m/%Y") == "2007-02-01" | as.Date(data$Date, format = "%d/%m/%Y") == "2007-02-02"),]
filtereddata$Date <- as.Date(filtereddata$Date, format = "%d/%m/%Y")
filtereddata$DateTime <- with(filtereddata, as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S", tz = "GMT"))
filtereddata$Sub_metering_1 <- as.numeric(as.character(filtereddata$Sub_metering_1))
filtereddata$Sub_metering_2 <- as.numeric(as.character(filtereddata$Sub_metering_2))
filtereddata$Sub_metering_3 <- as.numeric(as.character(filtereddata$Sub_metering_3))


png(filename="plot3.png")
with(filtereddata,{
  plot(DateTime,Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab =" ")
  points(DateTime,Sub_metering_2, type='l', col="red")
  points(DateTime,Sub_metering_3, type='l', col="blue")
}
)
legend("topright", pch = "_", col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()
