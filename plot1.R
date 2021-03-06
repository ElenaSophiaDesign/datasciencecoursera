##    Dataset "Electric power consumption" is downloaded in the working directory

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

##    Create Global Active Power histogram 
hist(dataKeep$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
