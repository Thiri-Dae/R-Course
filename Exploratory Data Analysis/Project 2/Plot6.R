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
BC_V_E <- vehicles_Emissions[vehicles_Emissions$fips=="24510",]

# Subset the vehicles Emissions data for Baltimore City
LA_V_E <- vehicles_Emissions[vehicles_Emissions$fips=="06037",]

##Add a new colomn with specific city names
BC_V_E$city <- "Baltimore City"
LA_V_E$city <- "Los Angeles County"

# Bind the data together for Baltimore and LA
BC_LA_V_E <- rbind(BC_V_E, LA_V_E)

##Create file for plot
png("plot6.png", width = 480, height = 480, units = "px", bg= "white")

##Create plot and set themes
BC_LA_comparison_Vehicle_Emissions <- ggplot(BC_LA_V_E, aes(x = factor(year), y = Emissions/10^3, fill = "city")) +
        geom_bar(aes(fill = year), stat = "identity", fill = "firebrick") +
        facet_grid(scales = "free_y", space = "free", .~city,) +
        guides(fill = FALSE) + 
        theme(axis.text = element_text(size = 12), panel.background = element_rect(fill = "white", colour = "grey")) + 
        labs(x ="Years", y = expression("Total PM"[2.5]*" Emission (Thousands of Tons)")) + 
        labs(title = expression(atop("PM"[2.5]*" Emissions for Motor Vehicles in", paste("Baltimore City and Los Angles County")), face = "bold", fontsize = 25))

print(BC_LA_comparison_Vehicle_Emissions)

dev.off()