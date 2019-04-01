library(dplyr)
library(ggplot2)
NEI <- readRDS("data/summarySCC_PM25.rds")

bytype <- group_by(NEI, year, type)
bytype <- select(bytype, Emissions, type, year)
bytype <- summarise(bytype, emi = sum(Emissions))

png("plot3.png")

ggplot(bytype, aes(x=year, y=emi, fill=type)) +
  geom_point() +
  facet_grid(rows = vars(type), scales = "free") +
  labs(x="Year", y="Emissions", title = "Emission by Type") +
  theme_minimal()

dev.off()

  