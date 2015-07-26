##Load ggplot2
library(ggplot2)

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

##Subset the data for Vehicles
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehicles_SCC <- SCC[vehicles,]$SCC
vehicles_Emissions <- NEI[NEI$SCC %in% vehicles_SCC,]

# Subset the vehicles Emissions data for Baltimore City
B_V_E <- vehicles_Emissions[vehicles_Emissions$fips=="24510",]

##Create file for plot
png("plot5.png", width = 480, height = 480, units = "px", bg= "white")

##Create plot and set themes
Baltimore_Vehicle_Emissions <- ggplot(B_V_E, aes(factor(year), Emissions/10^3)) +
        geom_bar(stat = "identity", fill = "purple") +
        theme(axis.text = element_text(size = 12), panel.background = element_rect(fill = "white", colour = "grey")) + 
        labs(x ="Years", y = expression("Total PM"[2.5]*" Emission (Thousands of Tons)")) + 
        labs(title = expression(atop("PM"[2.5]*" Emissions for Motor Vehicles", paste(" in Baltimore City")), face = "bold", fontsize = 25))

print(Baltimore_Vehicle_Emissions)

dev.off()