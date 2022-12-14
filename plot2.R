library(dplyr)
library(data.table)

nei <- readRDS("./data/summarySCC_PM25.rds")
nei <- data.table(nei)

to_plot <- nei %>% filter(fips == "24510") %>% select(Emissions, year) %>% group_by(year) %>% summarise(pm25 = as.integer(sum(Emissions)))
png(filename = 'plot2.png', width=1280, height = 720)
plot(to_plot$year, to_plot$pm25, ylab = "PM25 Emissions in Baltimore", xlab = "Year", pch = 20)
lines(to_plot$year, to_plot$pm25)
dev.off()