##download file

if(!file.exists("Fhousehold_power_consumption.zip")) {
        
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        f <- file.path(getwd(), "Fhousehold_power_consumption.zip")
        download.file(url, f, mode = "wb")
        unzip ("Fhousehold_power_consumption.zip", exdir = getwd())
}
##read in data
HHPD <- read.csv("Household_Power_Consumption.txt", header = TRUE, sep = ";",stringsAsFactors=FALSE, dec="."
                 , na.strings = "?", colClasses=c("character", "character", "numeric", "numeric", "numeric", 
                                                  "numeric", "numeric", "numeric", "numeric"))        
##create subset 
select_HHPD <- HHPD[HHPD$Date %in% c("1/2/2007", "2/2/2007"), ]

##create a file and a plot
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "white")
hist(select_HHPD$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()