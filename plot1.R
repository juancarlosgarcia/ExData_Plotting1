# plot1.R - Histogram of Global Active Power

#Read Data from csv. Load only the data that is need.
require(data.table)
## A new class is required to handle the date format.
setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y"))
power_data<-read.table("../household_power_consumption.txt",sep=';',header=T
                       ,colClasses=c('myDate','NULL','numeric'
                                    ,'NULL','NULL','NULL','NULL','NULL','NULL')
                       ,na.strings='?')

#Subset the data loaded only for two days
power_data <- subset(power_data,power_data$Date>=as.Date("2007-02-01") & power_data$Date<=as.Date("2007-02-02"))

#Open the PNG device
png("plot1.png",height=480,width=480)

#Create histogram
hist(power_data$Global_active_power,col='red'
      ,xlab='Global Active Power (kilowatts)'
      ,main='Global Active Power'
    )

#Close the PNG device
dev.off()
