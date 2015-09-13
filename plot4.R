library(dplyr)

# Download and unzip data.
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip", method = 'curl')
unzip("household_power_consumption.zip", "household_power_consumption.txt")

# Read in the data.
df <- read.csv2('household_power_consumption.txt', na.strings = '?', stringsAsFactors=F)

# Create a datetime field for subsetting.
df$DateTime <- paste(df$Date, df$Time, sep = " ")
df$DateTime <- as.POSIXct(strptime(df$DateTime,format="%d/%m/%Y %T"))

# Subset using the dplyr library.
dfSubset <- filter(df, df$DateTime > as.POSIXct("2007-02-01 00:00:00"), df$DateTime < as.POSIXct("2007-02-03 00:00:00"))

# Create the PNG
png("plot4.png") 

# Set up the screen device grid.
par(mfrow = c(2,2))

# Plot global active power
plot(dfSubset$DateTime, dfSubset$Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)")

# Plot Voltage
plot(dfSubset$DateTime, dfSubset$Voltage, type="l", xlab = "", ylab = "Voltage")

# Plot Sub metering
plot(dfSubset$DateTime, dfSubset$Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering")

lines(dfSubset$DateTime, dfSubset$Sub_metering_2, col = "red")

lines(dfSubset$DateTime, dfSubset$Sub_metering_3, col = "blue")

legend( x='topright', bty='l', 
        legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
        lwd=1, lty=c(1,1,1), col = c("black", "red", "blue"))

# Plot global reactive power.
plot(dfSubset$DateTime, dfSubset$Global_reactive_power, type="l", xlab = "", ylab = "Global_reactive_power")

dev.off()
