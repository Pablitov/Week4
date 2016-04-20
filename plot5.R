

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

# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?


ind2 <- grep("(.*)[Vv]ehicle(.*)",SCC$Short.Name)
ind3 <- grep("(.*)[Vv]ehicle(.*)",SCC$SCC.Level.Three)
ind4 <- grep("(.*)[Vv]ehicle(.*)",SCC$SCC.Level.Four)

scccodes <- unique(SCC$SCC[unique(c(ind3,ind4,ind5))])

BMnei    <- subset(NEI,fips == "24510")
neiind <- which(BMnei$SCC %in% scccodes)
temissions <- tapply(BMnei$Emissions[neiind],BMnei$year[neiind],sum)

tyears <- c(1999, 2002, 2005, 2008)
barplot(temissions,tyears,xlab="Year",ylab="Emissions (Tons)",main="Baltimore Vehicle-Related Emissions",col=rgb(0,0.5,0.5))

dev.copy(png, file = "plot5.png")
dev.off()
