Sys.setlocale("LC_ALL", "English")

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"),header=TRUE,na.strings = "NA",sep = ";")
unlink(temp)

filtereddata <- data[(as.Date(data$Date, format = "%d/%m/%Y") == "2007-02-01" | as.Date(data$Date, format = "%d/%m/%Y") == "2007-02-02"),]
filtereddata$Date <- as.Date(filtereddata$Date, format = "%d/%m/%Y")
filtereddata$Global_active_power <- as.numeric(as.character(filtereddata$Global_active_power))
filtereddata$DateTime <- with(filtereddata, as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S", tz = "GMT"))

png(filename="plot2.png")
with(filtereddata,plot(DateTime,Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab =" "))
dev.off()
