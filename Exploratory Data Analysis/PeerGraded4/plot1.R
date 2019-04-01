library(dplyr)
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

byyear <- group_by(NEI, year)
x <- summarise(byyear, sum(Emissions))
png("plot1.png")
barplot(x$`sum(Emissions)`, ylim = c(0,8000000), names.arg = c("1999", "2002", "2005", "2008"), ylab = "Emissions", xlab = "Year", main = "Emissions Per Year", col = "red")
dev.off()