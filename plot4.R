# plot4.R - Multiplot of Global active power, Voltage, Submetering and Global reactive power

#Read Data from csv. Load only the data that is need.
require(data.table)
## A new class is required to handle the date format.
setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y"))
power_data<-read.table("../household_power_consumption.txt",sep=';',header=T
                       ,colClasses=c('myDate','character','numeric'
                                     ,'numeric','numeric','NULL','numeric','numeric','numeric')
                       ,na.strings='?')

#Subset the data loaded only for two days
power_data <- subset(power_data,power_data$Date>=as.Date("2007-02-01") & power_data$Date<=as.Date("2007-02-02"))
#Combine Date and Time
power_data$DateTime <- strptime(paste(power_data$Date,power_data$Time),"%Y-%m-%d %H:%M:%S")

#Open the PNG device
png("plot4.png",height=480,width=480)

# Configure multiplot
par(mfrow=c(2,2))

#Create Plot - Global Power
plot(power_data$DateTime, power_data$Global_active_power,pch=NA
     ,xlab=""
     ,ylab="Global Active Power (kilowatts)"
)
lines(power_data$DateTime,power_data$Global_active_power)

#Create Plot - Voltage
plot(power_data$DateTime, power_data$Voltage,pch=NA
     ,xlab="datetime"
     ,ylab="Voltage"
)
lines(power_data$DateTime,power_data$Voltage)

#Create Plot - Submetering
plot(power_data$DateTime, power_data$Sub_metering_1, pch=NA
     ,xlab=""  
     ,ylab="Energy by sub metering"
)
colors = c("black","red","blue")
sapply(1:3,function(x) lines(x=power_data$DateTime,y=power_data[,x+5], col=colors[x]))
legend('topright', names(power_data[c(6:8)]),lty=c(1,1,1), col=colors,bty='n')

#Create Plot - Reactive Power
plot(power_data$DateTime, power_data$Global_reactive_power,pch=NA
     ,xlab="datetime"
     ,ylab=names(power_data[4])
)
lines(power_data$DateTime,power_data$Global_reactive_power)

#Close the PNG device
dev.off()