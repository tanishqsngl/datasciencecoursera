library(dplyr)
library(ggplot2)

NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

x <- grep("Fuel Comb .* [Cc]oal", SCC$EI.Sector)
coal <- SCC[x,]
bycoal <- inner_join(x = NEI, y = coal, by = "SCC")

byyear <- group_by(bycoal, year, SCC.Level.Two)
last <- summarise(byyear, emi=sum(Emissions))

png("plot4.png")
ggplot(last, aes(x=year, y=emi)) +
  geom_point() +
  facet_wrap(vars((SCC.Level.Two)), scales = "free") +
  labs(x="Year", y="Emissions", title = "Emission by Coal Combustion") +
  theme_minimal()
dev.off()