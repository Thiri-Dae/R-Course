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

##Subset the data for Coal and Combustion related sources
Combustion <- grepl("comb", SCC$SCC.Level.One, ignore.case = TRUE)
Coal <- grepl("coal", SCC$SCC.Level.Four, ignore.case = TRUE) 
Coal_Combustion <- (Combustion & Coal)
C_C_SCC <- SCC[Coal_Combustion,]$SCC
C_C_Emissions <- NEI[NEI$SCC %in% C_C_SCC,]

##Create file for plot
png("plot4.png", width = 480, height = 480, units = "px", bg= "white")

##Create plot and set themes
Coal_Combustion_Emissions <- ggplot(C_C_Emissions, aes(factor(year), Emissions/10^6)) +
        geom_bar(stat = "identity", fill = "red") +
        theme(axis.text = element_text(size = 12), panel.background = element_rect(fill = "white", colour = "grey")) + 
        labs(x ="Years", y = expression("Total PM"[2.5]*" Emission (Millions of Tons)")) + 
        labs(title = expression(atop("PM"[2.5]*" Emissions for Coal and Combustion", paste(" related Sources in the US")), face = "bold", fontsize = 25))

print(Coal_Combustion_Emissions)

dev.off()