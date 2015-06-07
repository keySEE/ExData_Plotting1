#dataset: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Dear Peers! Please attention: My R program have a russian localization and days of the week on the png plot was printed in russian text


#read_data
#power_data <- read.table("household_power_consumption.txt", colClasses = "character", header = TRUE, nrows = 100000, na.strings = "?", sep=";")
power_data <- read.table("household_power_consumption.txt", colClasses = "character", header = TRUE, na.strings = "?", sep=";")

library(dplyr)

#filter data for two days: 2007-02-01 and 2007-02-02
power_2day <- filter(power_data, as.Date(Date, "%d/%m/%Y") == "2007-02-01" | as.Date(Date, "%d/%m/%Y") == "2007-02-02")
rm(power_data)

#"Date" "Time" "Global_active_power" "Global_reactive_power" "Voltage" "Global_intensity" "Sub_metering_1" "Sub_metering_2" "Sub_metering_3"  

#converting character to numeric data
power_2day$Global_active_power <- as.numeric(power_2day$Global_active_power)
power_2day$Date <- as.Date(power_2day$Date, "%d/%m/%Y")
power_2day$Sub_metering_1 <- as.numeric(power_2day$Sub_metering_1)
power_2day$Sub_metering_2 <- as.numeric(power_2day$Sub_metering_2)
power_2day$Sub_metering_3 <- as.numeric(power_2day$Sub_metering_3)


# join columns Date and Time into one object
datetime <- as.POSIXct(paste(power_2day$Date, power_2day$Time), format="%Y-%m-%d %H:%M:%S")

# make a plot
with(power_2day, plot(datetime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(subset(power_2day), lines(datetime, Sub_metering_2, col = "red"))
with(subset(power_2day), lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", lty = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file = "plot3.png")
dev.off()

