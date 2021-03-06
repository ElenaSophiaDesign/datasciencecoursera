##    Dataset "Electric power consumption" is downloaded in the working directory

library(lubridate)
library(dplyr)

##    Set up parameters: dataset names, plot start and end dates 
downZip <- "exdata_data_household_power_consumption.zip"
downTxt <-  "household_power_consumption.txt"
startDate <- "1/2/2007"
endDate <- "2/2/2007"

##    Read in a dataset sample
initial <- read.table(unz(downZip, downTxt), nrows=10, sep = ";", na.strings = "?", header = TRUE, stringsAsFactors = FALSE)

##    Extract data classes fomr the sample
classes <- sapply(initial, class)

##    Read in entire dataset
initial <- read.table(unz(downZip, downTxt), sep = ";", na.strings = "?", header = TRUE, colClasses = classes, stringsAsFactors = FALSE)

##    Subset data for the plot dates
dataKeep <- initial[(initial$Date == startDate | initial$Date == endDate),]

##    Delete downloaded dataset
rm(initial)

##  Convert Date and Time strings into a POSIXct date time
dataKeep$Date <- paste(dataKeep$Date, dataKeep$Time)
dataKeep$Date <- dmy_hms(dataKeep$Date)

##    Create Energy Sub Metering Plot 
dataKeep <- mutate(dataKeep, Sub_metering = Sub_metering_1)
with(dataKeep, plot(Date, Sub_metering, type = 'n', 
                    xlab = "", ylab = "Energy Sub Metering"))
with(dataKeep, points(Date, Sub_metering, type = 'l'))
dataKeep$Sub_metering <- dataKeep$Sub_metering_2
with(dataKeep, points(Date, Sub_metering, type = 'l', col = "red"))
dataKeep$Sub_metering <- dataKeep$Sub_metering_3
with(dataKeep, points(Date, Sub_metering, type = 'l', col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

