library(dplyr)
library(data.table)
library(ggplot2)

nei <- readRDS("./data/summarySCC_PM25.rds")
nei <- data.table(nei)
scc <- readRDS("./data/Source_Classification_Code.rds")
scc <- data.table(scc)

fips_bal <- "24510"
fips_la <- "06037"
lookup <- data.frame(city=c("Baltimore", "Los Angeles"), fips=c(fips_bal, fips_la))

scc_motor_vehicles <- as.vector(scc$SCC[grepl(scc$EI.Sector, pattern = "Mobile.+Vehicles")] %>% unique())
nei_motor_vehicles <- nei[nei$SCC %in% scc_motor_vehicles, ]

nei_balt_la <- nei_motor_vehicles %>% filter(fips %in% c(fips_la, fips_bal))
nei_balt_la$city <- sapply(nei_balt_la$fips, function(x) lookup[lookup$fips == x, 1])

png(filename = 'plot6.png', width=1280, height = 720)
ggplot(data = nei_balt_la %>% 
         group_by(city,year) %>% 
         select(city, Emissions, year) %>% 
         summarise(sum_em = sum(Emissions)), aes(x = year, y=sum_em)) + 
  facet_grid(city ~ ., scales = "free_y") + 
  geom_line(linetype=2, size=1, color="red") + 
  xlab("Year") + 
  ylab("Sum of PM2.5 Emissions")

dev.off()


