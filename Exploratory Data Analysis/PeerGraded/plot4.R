library(dplyr)
powerdata <- read.csv("~/datasciencecoursera/Exploratory Data Analysis/PeerGraded/data/household_power_consumption.txt", sep=";", na.strings="?")
powerdata$Date <- as.Date.character(powerdata$Date, format = "%d/%m/%Y")
bydate <- filter(powerdata, Date >= "2007-02-01" & Date <= "2007-02-02")
y <- paste(bydate$Date, bydate$Time) 
y <- strptime(y, format = "%Y-%m-%d %H:%M:%S")
png("plot4.png")
par(mfrow=c(2,2))
plot(x, bydate$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
plot(x, bydate$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

plot(y, bydate$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(y, bydate$Sub_metering_2, col="red")
lines(y, bydate$Sub_metering_3, col="blue")
legend("topright", c("Sub_metring_1","Sub_metring_2", "Sub_metring_3"), lwd = 2, col = c("black", "red","blue"))

plot(x, bydate$Global_reactive_power, type = "l", xlab = "datetime")
dev.off()

