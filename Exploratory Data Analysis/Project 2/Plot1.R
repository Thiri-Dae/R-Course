##Download File
if(!file.exists("FNEI_data.zip")) {
        
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        f <- file.path(getwd(), "FNEI_data.zip")
        download.file(url, f, mode = "wb")
        unzip ("FNEI_data.zip", exdir = getwd())
}
##read in data
        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds")

##Create data for plot
Yearly_Emissions <- aggregate(Emissions ~ year, NEI, sum)

##Create file for plot
png("plot1.png", width = 480, height = 480, units = "px", bg= "white")

##Create plot
barplot((Yearly_Emissions$Emissions)/10^6, 
        names.arg = Yearly_Emissions$year, 
        xlab = "Years", 
        ylab = expression("PM"[2.5]*" emissions (million tons)"), 
        main = expression("Total PM"[2.5]*" emissions from All Sources in the US"),
        col  = "Red")
dev.off()
