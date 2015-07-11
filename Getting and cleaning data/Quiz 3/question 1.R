library(dplyr)
library(tcltk2)
library(RMySQL)
options(sqldf.driver = "RSQLite")

url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
f <- file.path(getwd(), "Fss06hid.csv")
download.file(url, f, mode = "wb")
options(sqldf.driver = "RSQLite")
USC2006 <- read.csv("Fss06hid.csv")
agricultureLogical <- which(USC2006$ACR == 3 & USC2006$AGS == 6)
print(agricultureLogical)
