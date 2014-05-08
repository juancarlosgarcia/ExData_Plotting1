require(data.table)
setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y"))
power_data<-read.table("../household_power_consumption.txt",sep=';',header=T
                       ,colClasses=c('myDate','character','numeric'
                                     ,'NULL','NULL','NULL','NULL','NULL','NULL')
                       ,na.strings='?')
power_data <- subset(power_data,power_data$Date>=as.Date("2007-02-01") & power_data$Date<=as.Date("2007-02-02"))
power_data$DateTime <- strptime(paste(power_data$Date,power_data$Time),"%Y-%m-%d %H:%M:%S")
png("plot2.png",height=480,width=480)
plot(power_data$DateTime, power_data$Global_active_power,pch=NA
     ,xlab=""
     ,ylab="Global Active Power (kilowatts)"
    )
lines(power_data$DateTime,power_data$Global_active_power)
dev.off()