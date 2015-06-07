#dataset: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

#read_data
power_data <- read.table("household_power_consumption.txt", colClasses = "character", header = TRUE, na.strings = "?", sep=";")

library(dplyr)

#filter data for two days: 2007-02-01 and 2007-02-02
power_2day <- filter(power_data, as.Date(Date, "%d/%m/%Y") == "2007-02-01" | as.Date(Date, "%d/%m/%Y") == "2007-02-02")
rm(power_data)

#"Date" "Time" "Global_active_power" "Global_reactive_power" "Voltage" "Global_intensity" "Sub_metering_1" "Sub_metering_2" "Sub_metering_3"  

#converting character to numeric data
power_2day$Global_active_power <- as.numeric(power_2day$Global_active_power)
# make a histogram
hist(power_2day$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.copy(png, file = "plot1.png")
dev.off()
