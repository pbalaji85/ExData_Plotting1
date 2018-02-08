## Read in the full household power consumption dataset
power <- read.table('household_power_consumption.txt',sep=";",na.strings = "?", header = T)

## Merge the data and time together into a new column
power$DateTime <- paste(power$Date, power$Time, sep = " ")

## Format the data object using as.Date and the new datetime object using strptime.
power$Date <- power$Date <- as.Date(power$Date, format="%d/%m/%Y")
power$DateTime <- as.POSIXct(strptime(power$DateTime, format = "%d/%m/%Y %H:%M:%S"))

## Subset the power df to get the data for the 2 day we need.
need_power <- power[power$Date>='2007-02-01' & power$Date<='2007-02-02',]

## Open a graphics device. I am going to go ahead and specify the plot width and height,
## although 480 x 480 is the default
png(filename = 'plot3.png', width = 480, height = 480, units = 'px')

plot(need_power$DateTime,need_power$Sub_metering_1, col = 'black', type = 'l', ylab = 'Energy Sub Metering'
     , xlab = " ")
points(need_power$DateTime, need_power$Sub_metering_2, type = 'l', col ='red')
points(need_power$DateTime, need_power$Sub_metering_3, type = 'l', col ='blue')
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1,col = c('black','red','blue'))

dev.off()

