require(data.table)
setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y"))
power_data<-read.table("../household_power_consumption.txt",sep=';',header=T
                       ,colClasses=c('myDate','NULL','numeric'
                                    ,'NULL','NULL','NULL','NULL','NULL','NULL')
                       ,na.strings='?')
power_data <- subset(power_data,power_data$Date>=as.Date("2007-02-01") & power_data$Date<=as.Date("2007-02-02"))
png("plot1.png",height=480,width=480)
hist(power_data$Global_active_power,col='red'
      ,xlab='Global Active Power (kilowatts)'
      ,main='Global Active Power'
    )
dev.off()
