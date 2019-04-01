library(dplyr)
library(ggplot2)

NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

mobile <- filter(SCC, SCC.Level.One == "Mobile Sources" & Data.Category == "Onroad")
bymotor <- semi_join(x = NEI, y = mobile, by = "SCC")
bymotor <- filter(bymotor, fips=="24510")

byyear <- group_by(bymotor, year)
byyear <- summarise(byyear, emi=sum(Emissions))

png("plot5.png")

ggplot(byyear, aes(x=year, y=emi)) +
  geom_point() +
  labs(x="Year", y="Emissions", title = "Emission by Motor Vehicles") +
  theme_minimal()
dev.off()
