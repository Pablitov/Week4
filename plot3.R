

# 0. Preprocessing

library(curl)
library(ggplot2)

setwd("C:/Users/PPCCCC/Documents/R/Module4 EDA")

### 0.1 File donwload and load into environment
furl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
fname <- "exdata-data-NEI_data.zip"
download.file(furl,destfile = fname)
unzip(fname)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


### Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
### which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
### Which have seen increases in emissions from 1999-2008?

### First we create the indecees where the 
BMnei    <- subset(NEI,fips == "24510")

ipoint    <- which(NEI$fips == "24510" & NEI$type=="POINT")
inonpoint <- which(NEI$fips == "24510" & NEI$type=="NONPOINT")
iroad     <- which(NEI$fips == "24510" & NEI$type=="ON-ROAD")
inonroad  <- which(NEI$fips == "24510" & NEI$type=="NON-ROAD")

Tpoint    <- tapply(NEI$Emissions[ipoint], NEI$year[ipoint],sum)
Tnonpoint <- tapply(NEI$Emissions[inonpoint], NEI$year[inonpoint],sum)
Troad     <- tapply(NEI$Emissions[iroad], NEI$year[iroad],sum)
Tnonroad  <- tapply(NEI$Emissions[inonroad], NEI$year[inonroad],sum)

g <- ggplot(BMnei, aes(factor(year),Emissions,fill=type)) #,color=factor(Emissions))) # y=Emissions,
            
g+geom_bar(stat="identity") + guides(fill=FALSE) + facet_grid(~type) + 
  labs(x="Year", y= "PM25 (Tons)", title = "Baltimore City - Total Emissions") 


dev.copy(png, file = "plot3.png")
dev.off()

