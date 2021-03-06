# plot2.R - Global Active Power in Time

#Read Data from csv. Load only the data that is need.
require(data.table)
## A new class is required to handle the date format.
setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y"))
power_data<-read.table("../household_power_consumption.txt",sep=';',header=T
                       ,colClasses=c('myDate','character','numeric'
                                     ,'NULL','NULL','NULL','NULL','NULL','NULL')
                       ,na.strings='?')

#Subset the data loaded only for two days
power_data <- subset(power_data,power_data$Date>=as.Date("2007-02-01") & power_data$Date<=as.Date("2007-02-02"))
#Combine Date and Time
power_data$DateTime <- strptime(paste(power_data$Date,power_data$Time),"%Y-%m-%d %H:%M:%S")

#Open the PNG device
png("plot2.png",height=480,width=480)

#Create plot of Power in time
plot(power_data$DateTime, power_data$Global_active_power,pch=NA
     ,xlab=""
     ,ylab="Global Active Power (kilowatts)"
    )
lines(power_data$DateTime,power_data$Global_active_power)

#Close the PNG device
dev.off()