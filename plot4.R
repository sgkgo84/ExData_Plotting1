## Subset of specified dates

date_1 <- all_consumption[all_consumption$Date=="1/2/2007",]
date_2 <- all_consumption[all_consumption$Date=="2/2/2007",]
selected_dates <- rbind(date_1, date_2)

date_time <- strptime(paste(selected_dates$Date, selected_dates$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

## Plotting

par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))


## Plot row 1 column 1
power <- as.numeric(selected_dates$Global_active_power)

plot(date_time, power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

## Plot row 1 column 2

voltage <- as.numeric(selected_dates$Voltage)
plot(date_time, voltage, type="l", xlab="datetime")


## Plot row 2 column 1
plot(date_time, selected_dates$Sub_metering_1, xlab="", ylab="Energy sub metering", type="l")
lines(date_time, selected_dates$Sub_metering_2, col="red")
lines(date_time, selected_dates$Sub_metering_3, col="blue")

legend("topright", col=c('black', 'red', 'blue'), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)

## Plot row 2 column 2

Global_reactive_power <- as.numeric(selected_dates$Global_reactive_power)
plot(date_time, Global_reactive_power, type="l", xlab="datetime")

dev.copy(png, file = "plot4.png")
dev.off()

## End