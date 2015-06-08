getwd()
setwd("d:/DataScienceSpecialization/ExploratoryDataAnalysis/Project")

#File should be in a folder "DATA" in your working directory
file <- ("DATA/household_power_consumption.txt")

hh_pow_con_full <- read.delim(file, header = TRUE, sep = ";")

hh_pow_con <- hh_pow_con_full[as.Date(hh_pow_con_full$Date,"%d/%m/%Y")=='2007-02-01' | as.Date(hh_pow_con_full$Date,"%d/%m/%Y")=='2007-02-02',]
hh_pow_con$Date<-as.Date(hh_pow_con$Date,"%d/%m/%Y")
hh_pow_con$Time<-strftime(strptime(hh_pow_con$Time,"%H:%M:%S"), format = "%H:%M:%S", usetz = FALSE)
hh_pow_con$Global_active_power<-as.numeric(as.character(hh_pow_con$Global_active_power))
hh_pow_con$Day <- with(hh_pow_con, as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"))
png(filename="plot3.png")
plot(as.numeric(as.character(hh_pow_con$Sub_metering_1)) ~ hh_pow_con$Day,type="n",ylab="Energy sub metering",xlab="")
points(as.numeric(as.character(hh_pow_con$Sub_metering_1)) ~ hh_pow_con$Day,type="l")
points(as.numeric(as.character(hh_pow_con$Sub_metering_2)) ~ hh_pow_con$Day,type="l",col="red")
points(as.numeric(as.character(hh_pow_con$Sub_metering_3)) ~ hh_pow_con$Day,type="l",col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),pch="-",col = c("black","red","blue"))
dev.off()