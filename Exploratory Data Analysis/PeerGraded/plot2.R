library(dplyr)
powerdata <- read.csv("~/datasciencecoursera/Exploratory Data Analysis/PeerGraded/data/household_power_consumption.txt", sep=";", na.strings="?")
powerdata$Date <- as.Date.character(powerdata$Date, format = "%d/%m/%Y")
bydate <- filter(powerdata, Date >= "2007-02-01" & Date <= "2007-02-02")
x <- paste(bydate$Date, bydate$Time) 
x <- strptime(x, format = "%Y-%m-%d %H:%M:%S")
png("plot2.png")
plot(x, bydate$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()


