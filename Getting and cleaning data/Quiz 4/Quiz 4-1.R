url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
f <- file.path(getwd(), "Fss06hid.csv")
download.file(url, f, mode = "wb")
USC2006 <- read.csv("Fss06hid.csv")
strsplit(names(USC2006), "wgtp")