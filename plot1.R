getwd()
setwd("d:/DataScienceSpecialization/ExploratoryDataAnalysis/Project")

#File should be in a folder "DATA" in your working directory
file <- ("DATA/household_power_consumption.txt")

hh_pow_con_full <- read.delim(file, header = TRUE, sep = ";")

hh_pow_con <- hh_pow_con_full[as.Date(hh_pow_con_full$Date,"%d/%m/%Y")=='2007-02-01' | as.Date(hh_pow_con_full$Date,"%d/%m/%Y")=='2007-02-02',]
hh_pow_con$Date<-as.Date(hh_pow_con$Date,"%d/%m/%Y")
hh_pow_con$Time<-strftime(strptime(hh_pow_con$Time,"%H:%M:%S"), format = "%H:%M:%S", usetz = FALSE)
hh_pow_con$Global_active_power<-as.numeric(as.character(hh_pow_con$Global_active_power))

png(filename="plot1.png")
hist(hh_pow_con$Global_active_power,xlab = "Global Active Power (kilowatts)",col="orangered", main="Global Active Power",breaks = 11)
dev.off()
