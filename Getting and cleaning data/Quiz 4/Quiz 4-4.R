library(dplyr)
library(tcltk2)
library(RMySQL)
options(sqldf.driver = "RSQLite")

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
f <- file.path(getwd(), "FGDP.csv")
download.file(url, f, mode = "wb")
GDP190 <- data.table(read.csv("FGDP.csv", header = FALSE, skip = 5, nrow = 215))

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
f <- file.path(getwd(), "FEDSTATS_Country.csv")
download.file(url, f, mode = "wb")
FEDSTATS <- data.table(read.csv("FEDSTATS_Country.csv"))

colnames(GDP190) <- c("CountryCode", "rankingGDP", "V3", "Long.Name", "gdp", "V6", "V7", "V8", "V9", "V10")

country_data <- merge(GDP190, FEDSTATS, all = TRUE, by = c("CountryCode"))

June_Year <- grep('Fiscal.*year.*end.*June', country_data$Special.Notes)

print(length(June_Year))
