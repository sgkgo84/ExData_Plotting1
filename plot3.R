### plot3.R

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

date_time <- strptime(paste(selected_dates$Date, selected_dates$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

plot(date_time, selected_dates$Sub_metering_1, xlab="", ylab="Energy sub metering", type="l")
lines(date_time, selected_dates$Sub_metering_2, col="red")
lines(date_time, selected_dates$Sub_metering_3, col="blue")

legend("topright", col=c('black', 'red', 'blue'), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)

dev.copy(png, file = "plot3.png")
dev.off()

## End