library(dplyr)
library(data.table)
library(ggplot2)

nei <- readRDS("./data/summarySCC_PM25.rds")
nei <- data.table(nei)
scc <- readRDS("./data/Source_Classification_Code.rds")
scc <- data.table(scc)

scc_motor_vehicles <- as.vector(scc$SCC[grepl(scc$EI.Sector, pattern = "Mobile.+Vehicles")] %>% unique())
nei_motor_vehicles <- nei[nei$SCC %in% scc_motor_vehicles, ]

png(filename = 'plot5.png', width=1280, height = 720)
plot(to_plot$year, to_plot$pm25, ylab = "PM25 Emissions from motor vehicle sources sources in Baltimore", xlab = "Year", pch = 20)
lines(to_plot$year, to_plot$pm25)
dev.off()