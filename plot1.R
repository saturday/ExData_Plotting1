library(dplyr)

# Download and unzip data.
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip", method = 'curl')
unzip("household_power_consumption.zip", "household_power_consumption.txt")

# Read in the data.
df <- read.csv2('household_power_consumption.txt', na.strings = '?')

# Create a datetime field for subsetting.
df$DateTime <- paste(df$Date, df$Time, sep = " ")
df$DateTime <- as.POSIXct(strptime(df$DateTime,format="%d/%m/%Y %T"))

# Subset using the dplyr library.
dfSubset <- filter(df, df$DateTime > as.POSIXct("2007-02-01 00:00:00"), df$DateTime < as.POSIXct("2007-02-03 00:00:00"))

# Create the PNG
png("plot1.png") 

# Convert the global active power column so we can use it in a histogram.
vectorGap <- as.numeric(as.vector(dfSubset$Global_active_power))

# Create the histogram, annotate and stylize.
hist(vectorGap, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

dev.off()
