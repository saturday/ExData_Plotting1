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

# Generate the plot, annotate and stylize.
plot(dfSubset$DateTime, dfSubset$Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)")

# Save to a PNG file.
dev.copy(png,'plot2.png')
dev.off()
