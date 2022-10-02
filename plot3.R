library(dplyr)
library(ggplot2)

nei <- readRDS("./data/summarySCC_PM25.rds")
nei <- data.table(nei)

to_plot <- nei %>% 
  filter(fips == "24510") %>% 
  select(Emissions, type,year) %>% 
  group_by(year, type) %>% 
  summarise(pm25 = as.integer(sum(Emissions)))

png(filename = 'plot3.png', width=1280, height = 720)

ggplot(to_plot, aes(year, pm25)) + 
  geom_line() + 
  facet_grid(type ~ . , scales = "fixed") + 
  xlab("Year") + 
  ylab("PM25 Emissions in Baltimore")

dev.off()
