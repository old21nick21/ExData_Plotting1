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

##This is new code to genereate new plot (Plot 4 - four plots on one page)

## First specify the layout - two rows and two cols to fit four graphs
par(mfrow=c(2,2))

## generate first plot - goes to the 1.1 quadrant
plot(twoDaysData$Global_active_power~twoDaysData$DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

## generate second plot - goes to the 1.2 quadrant
plot(twoDaysData$Voltage~twoDaysData$DateTime, type="l", ylab="Voltage (volt)", xlab="")

## generate third plot in three steps: each for different param
## a) first param in default color - when graph is created
plot(twoDaysData$Sub_metering_1~twoDaysData$DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

## b) second param in red - for sub_metering_2 - add to existing graph
lines(twoDaysData$Sub_metering_2~twoDaysData$DateTime,col='Red')

## c) third param in blue
lines(twoDaysData$Sub_metering_3~twoDaysData$DateTime,col='Blue')

## add legend
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

### generate the fourth plot - goes to 2.2 quadrant
plot(twoDaysData$Global_reactive_power~twoDaysData$DateTime, type="l", ylab="Global Rective Power (kilowatts)",xlab="")

## Save to png4 file
dev.copy(png, file="plot4.png", height=480, width=480)

## Finalize the file
dev.off()