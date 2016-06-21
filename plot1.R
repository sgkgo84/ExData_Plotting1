### plot1.R

install.packages("data.table")
library(data.table)

## Retrieve data

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (!file.exists("./data")) {
	dir.create("./data")
}

download.file(url,destfile="./data/zipdata.zip")
setwd("./data")
unzip("zipdata.zip")
setwd("..")

all_consumption <- read.table("./data/household_power_consumption.txt", sep=";", na.strings = "?", header=TRUE, stringsAsFactors=FALSE, dec=".")

## Subset of specified dates

date_1 <- all_consumption[all_consumption$Date=="1/2/2007",]
date_2 <- all_consumption[all_consumption$Date=="2/2/2007",]
selected_dates <- rbind(date_1, date_2)

## Produce plot and save
hist(selected_dates$Global_active_power, xaxt="n", xlim=c(0,6), ylim=c(0, 1200), xlab="Global Activer Power (kilowatts)", main="Global Active Power", col="red")
axis(1, at=seq(0, 6, by=2), labels=c("0", "2", "4", "6"))

dev.copy(png, file = "plot1.png")
dev.off()

## End