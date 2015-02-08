## Read all records from the source file
electricity <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

## convert Date column into date datatype
electricity$Date <- as.Date(electricity$Date, format="%d/%m/%Y")

## create a new dataset - for only two days
twoDaysData <- subset(electricity, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## merge date and time columns 
dateTime <- paste(as.Date(twoDaysData$Date), twoDaysData$Time)

## create a new column with date/time stamp
twoDaysData$DateTime <- as.POSIXct(dateTime)

## create a histogram on the screen
hist(twoDaysData$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## copy histogram from the screen to the png file
dev.copy(png, file="plot1.png", height=480, width=480)

## close the connection to finalize the file
dev.off()