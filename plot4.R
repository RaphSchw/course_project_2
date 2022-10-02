library(dplyr)
library(data.table)
library(ggplot2)

nei <- readRDS("./data/summarySCC_PM25.rds")
nei <- data.table(nei)
scc <- readRDS("./data/Source_Classification_Code.rds")
scc <- data.table(scc)

scc_list_comb <- scc[grepl(scc$EI.Sector, pattern = ".+Comb.+Coal"),]
scc_list_comb <- as.vector(scc_list_comb$SCC)
coal_comb_usa <- nei[nei$SCC %in% scc_list_comb, ]
to_plot <- coal_comb_usa %>% select(Emissions, year) %>% group_by(year) %>% summarise(pm25 = as.integer(sum(Emissions)))

png(filename = 'plot4.png', width=1280, height = 720)
plot(to_plot$year, to_plot$pm25, ylab = "PM25 Emissions from coal combustion-related sources", xlab = "Year", pch = 20)
lines(to_plot$year, to_plot$pm25)
dev.off()