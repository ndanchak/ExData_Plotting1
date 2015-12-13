temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"),header=TRUE,na.strings = "NA",sep = ";")
unlink(temp)

filtereddata <- data[(as.Date(data$Date, format = "%d/%m/%Y") == "2007-02-01" | as.Date(data$Date, format = "%d/%m/%Y") == "2007-02-02"),]
filtereddata$Global_active_power <- as.numeric(as.character(filtereddata$Global_active_power))

png(filename="plot1.png")
hist(filtereddata$Global_active_power
     ,xlab="Global Active Power (kilowatts)",col = "red",main="Global Active Power",breaks = 12)
dev.off()

