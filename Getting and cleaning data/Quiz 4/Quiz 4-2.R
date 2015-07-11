url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
f <- file.path(getwd(), "Fss06hid.csv")
download.file(url, f, mode = "wb")
GDP190 <- read.csv("FGDP.csv", skip = 5, nrows = 190, header = FALSE)
x <- as.numeric(gsub(",([0-9])", "\\1", GDP190[,5]))
print(mean(x))