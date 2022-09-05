library(dplyr)

nei <- readRDS("./data/summarySCC_PM25.rds")
scc <- readRDS("./data/Source_Classification_Code.rds")

test <- data.table(nei)
scc_list <- scc[grepl(scc$EI.Sector, pattern = ".+Comb.+Coal")]
scc_list <- as.vector(scc_list$SCC)
test <- test[test$SCC %in% scc_list, ]