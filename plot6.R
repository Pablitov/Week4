

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

# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County

ind2 <- grep("(.*)[Vv]ehicle(.*)",SCC$Short.Name)
ind3 <- grep("(.*)[Vv]ehicle(.*)",SCC$SCC.Level.Three)
ind4 <- grep("(.*)[Vv]ehicle(.*)",SCC$SCC.Level.Four)
scccodes <- unique(SCC$SCC[unique(c(ind2,ind3,ind4))])

LAnei    <- subset(NEI,fips == "06037")
LAneiind <- which(LAnei$SCC %in% scccodes)
LAtemissions <- tapply(LAnei$Emissions[LAneiind],LAnei$year[LAneiind],sum)

BMnei    <- subset(NEI,fips == "24510")
BMneiind <- which(BMnei$SCC %in% scccodes)
BMtemissions <- tapply(BMnei$Emissions[BMneiind],BMnei$year[BMneiind],sum)

yrange <- range(BMtemissions,LAtemissions)
tyears <- c(1999, 2002, 2005, 2008)

df<-data.frame(as.numeric(BMtemissions), as.numeric(LAtemissions))
names(df)<-c("Baltimore","LosAngeles")
df$year<-tyears

# par(mfrow=c(1,2))
# barplot(BMtemissions,tyears,ylim=yrange,xlab="Year",ylab="Emissions (Tons)",main="Baltimore Emissions",col=rgb(0,0.5,0.5))
# barplot(LAtemissions,tyears,ylim=yrange,xlab="Year",ylab="Emissions (Tons)",main="Los Angeles Emissions",col=rgb(0,0.5,0.5))

g <- ggplot(data=df,aes(year,Baltimore))
g+geom_bar(stat="identity")

dev.copy(png, file = "plot6.png")
dev.off()

