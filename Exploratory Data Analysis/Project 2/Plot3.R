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

##Subset the data for Baltimore City only
BC_Emissions <- subset(NEI, fips=="24510")

##Create file for plot
png("plot3.png", width = 480, height = 480, units = "px", bg= "white")

##Create plot and set themes
BC_Emissions_Type <- ggplot(BC_Emissions, aes(factor(year), Emissions, fill = type)) +
        geom_bar(stat = "identity") +
        theme(axis.text = element_text(size = 9), panel.background = element_rect(fill = "white", colour = "grey")) + 
        guides(fill = FALSE) +
        facet_grid(.~type, scales = "free",space = "free") + 
        labs(x ="Years", y = expression("Total PM"[2.5]*" Emission (Tons)")) + 
        labs(title = expression("PM"[2.5]*" Emissions for Baltimore City by Source Type"))

print(BC_Emissions_Type)

dev.off()