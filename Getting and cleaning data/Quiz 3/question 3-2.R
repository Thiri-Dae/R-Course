library(dplyr)
library(tcltk2)
library(RMySQL)
options(sqldf.driver = "RSQLite")
library(jpeg)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
f <- file.path(getwd(), "Fjeff.jpg")
download.file(url, f, mode = "wb")
jeff <- readJPEG("Fjeff.jpg", native = TRUE)
print(quantile(jeff, probs = c(0.3 , 0.8)))