

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

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?

pmbc <- subset(NEI,fips == "24510")
tyears <- c(1999, 2002, 2005, 2008)
temissions <- tapply(pmbc$Emissions,pmbc$year,sum)

barplot(temissions,tyears,xlab="Year",ylab="Emissions (Tons)",main="Total Baltimore City Emissions",col=rgb(0,0.5,0.5))

dev.copy(png, file = "plot2.png")
dev.off()
