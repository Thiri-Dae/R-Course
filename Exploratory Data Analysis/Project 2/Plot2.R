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

##Subset the data for Baltimore City only
BC_Emissions <- subset(NEI, fips=="24510")

##Create data for plot
Yearly_Emissions_BC <- aggregate(Emissions ~ year, BC_Emissions, sum)

##Create file for plot
png("plot2.png", width = 480, height = 480, units = "px", bg= "white")

##Create plot
barplot(Yearly_Emissions_BC$Emissions, 
        names.arg = Yearly_Emissions_BC$year, 
        xlab = "Years", 
        ylab = expression("PM"[2.5]*" emissions (tons)"), 
        main = expression("Total PM"[2.5]*" emissions for Baltimore City"),
        col  = "Blue")
dev.off()
