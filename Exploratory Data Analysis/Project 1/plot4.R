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
##create subset and strptime
select_HHPD <- HHPD[HHPD$Date %in% c("1/2/2007", "2/2/2007"), ]
time <- strptime(paste(select_HHPD$Date, select_HHPD$Time), "%d/%m/%Y %H:%M:%S")

##create a file and a plots
png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "white")

##set parameters for 4 plots
par(mfcol = c(2,2))

plot(time, select_HHPD$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

plot(time, select_HHPD$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(time, select_HHPD$Sub_metering_2, col = "red")
lines(time, select_HHPD$Sub_metering_3, col = "blue")
legend("topright", lty= 1, col = c("Black", "red", "blue"), legend = c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.9, bty="n")

plot(time, select_HHPD$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

plot(time, select_HHPD$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()