### plot2.R

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
power <- as.numeric(selected_dates$Global_active_power)

plot(date_time, power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.copy(png, file = "plot2.png")
dev.off()

## End