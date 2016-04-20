

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


# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
### First we find which are the Coal realted sources
ind3 <- grep("(.*)[Cc]oal(.*)",SCC$SCC.Level.Three)
ind4 <- grep("(.*)[Cc]oal(.*)",SCC$SCC.Level.Four)
ind5 <- grep("(.*)[Cc]oal(.*)",SCC$Short.Name)

scccodes <- unique(SCC$SCC[unique(c(ind3,ind4,ind5))])

neiind <- which(NEI$SCC %in% scccodes)

temissions <- tapply(NEI$Emissions[neiind],NEI$year[neiind],sum)

tyears <- c(1999, 2002, 2005, 2008)
barplot(temissions/10^6,tyears,xlab="Year",ylab="Emissions (M Tons)",main="US Coal-related Emissions",col=rgb(0,0.5,0.5))

dev.copy(png, file = "plot4.png")
dev.off()
