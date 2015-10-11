###Unzipped the txt file

##Loading the data

#Reading the entire data set 
#2,075,259 rows and 9 columns
#Missing values are coded as ?
data <-  read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
#Change date format
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
#Extracting data from the dates 2007-02-01 and 2007-02-02
dataWithinPeriod <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
#Convert the Date and Time variables using as.Date() and as.POSIXct()
dateTime <- paste(as.Date(dataWithinPeriod$Date), dataWithinPeriod$Time)
dataWithinPeriod$DateTime <- as.POSIXct(dateTime)



##Making Plots

#Plot of Sub_metering
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(dataWithinPeriod, {
  plot(Global_active_power~DateTime, type="l", ylab="Global Active Power", xlab="")
  plot(Voltage~DateTime, type="l", ylab="Voltage", xlab="")
  plot(Sub_metering_1~DateTime, type="l", ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), cex =0.55, lty=1, lwd=2, bty="n",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~DateTime, type="l", ylab="Global_reactive_power",xlab="")
})
#Save as PNG file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()