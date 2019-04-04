library(dplyr)
library(ggplot2)

NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

mobile <- filter(SCC, SCC.Level.One == "Mobile Sources" & Data.Category == "Onroad")
bymotor <- semi_join(x = NEI, y = mobile, by = "SCC")
bymotor <- filter(bymotor, fips=="24510" | fips=="06037")
bymotor[,1] <- sub("24510", "Baltimore City", bymotor[,1])
bymotor[,1] <- sub("06037", "Los Angeles County", bymotor[,1])

byyear <- group_by(bymotor, year, fips)
byyear <- summarise(byyear, emi=sum(Emissions))

png("plot6.png")

ggplot(byyear, aes(x=year, y=emi)) +
  geom_point() +
  facet_wrap(vars((fips)), scales = "fixed") +
  labs(x="Year", y="Emissions", title = "Emission by Motor Vehicles") +
  theme_minimal()
dev.off()
