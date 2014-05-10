# plot3.R - Global Active Power over Time by submeter

#Read Data from csv. Load only the data that is need.
require(data.table)
## A new class is required to handle the date format.
setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y"))
power_data<-read.table("../household_power_consumption.txt",sep=';',header=T
                       ,colClasses=c('myDate','character','numeric'
                                     ,'NULL','NULL','NULL','numeric','numeric','numeric')
                       ,na.strings='?')

#Subset the data loaded only for two days
power_data <- subset(power_data,power_data$Date>=as.Date("2007-02-01") & power_data$Date<=as.Date("2007-02-02"))
#Combine Date and Time
power_data$DateTime <- strptime(paste(power_data$Date,power_data$Time),"%Y-%m-%d %H:%M:%S")

#Open the PNG device
png("plot3.png",height=480,width=480)

#Create plot of Global Power over time by submeter
plot(power_data$DateTime, power_data$Sub_metering_1, pch=NA
     ,xlab=""  
     ,ylab="Energy by sub metering"
     )
colors = c("black","red","blue")
sapply(1:3,function(x) lines(x=power_data$DateTime,y=power_data[,x+3], col=colors[x]))
legend('topright', names(power_data[c(4:6)]),lty=c(1,1,1), col=colors)

#Close the PNG device
dev.off()