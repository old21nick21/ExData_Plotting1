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

##This is new code to genereate new plot (Plot 3)
##First line is created in default color, then blue and red lines are added

plot(twoDaysData$Sub_metering_1~twoDaysData$DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

## Red line for Sub_metering_2
lines(twoDaysData$Sub_metering_2~twoDaysData$DateTime,col='Red')

## Blue line for Sub_metering_3
lines(twoDaysData$Sub_metering_3~twoDaysData$DateTime,col='Blue')

## Add legend in the top-right corner
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Save to png3 file
dev.copy(png, file="plot3.png", height=480, width=480)

## Finalize the file
dev.off()