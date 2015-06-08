#dataset: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

#read_data
#"Date" "Time" "Global_active_power" "Global_reactive_power" "Voltage" "Global_intensity" "Sub_metering_1" "Sub_metering_2" "Sub_metering_3"  
colClasses <- c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
power_data <- read.table("household_power_consumption.txt", colClasses = colClasses, header = TRUE, na.strings = "?", sep=";")

library(dplyr)

#filter data for two days: 2007-02-01 and 2007-02-02
power_2day <- filter(power_data, as.Date(Date, "%d/%m/%Y") == "2007-02-01" | as.Date(Date, "%d/%m/%Y") == "2007-02-02")
rm(power_data) #remove main data frame



#converting character to numeric data
#power_2day$Global_active_power <- as.numeric(power_2day$Global_active_power)
power_2day$Date <- as.Date(power_2day$Date, "%d/%m/%Y")

# join columns Date and Time into one object
datetime <- as.POSIXct(paste(power_2day$Date, power_2day$Time), format="%Y-%m-%d %H:%M:%S")

#set an English locale
Sys.setlocale("LC_TIME", "eng")

# make a plot, where type = "l" is line.
plot(datetime, power_2day$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()

