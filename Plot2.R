## Read all records from the source file
## Same steps as for Plot 1
electricity <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

## convert Date column into date datatype
electricity$Date <- as.Date(electricity$Date, format="%d/%m/%Y")

## create a new dataset - for only two days
twoDaysData <- subset(electricity, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## merge date and time columns 
dateTime <- paste(as.Date(twoDaysData$Date), twoDaysData$Time)

## create a new column with date/time stamp
twoDaysData$DateTime <- as.POSIXct(dateTime)

##This is new code to genereate new plot (Plot 2)

plot(twoDaysData$Global_active_power~twoDaysData$DateTime, type="l",
     +      ylab="Global Active Power (kilowatts)", xlab="")

## Write new plot to the "plot 2" png file
dev.copy(png, file="plot2.png", height=480, width=480)

## Close the connection to finalize the file
dev.off()
