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
with(dataWithinPeriod, {plot(Sub_metering_1~DateTime, type="l", ylab="Energy sub metering", xlab="");lines(Sub_metering_2~DateTime,col='Red');lines(Sub_metering_3~DateTime,col='Blue')})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, cex = 0.7, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#Save as PNG file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()