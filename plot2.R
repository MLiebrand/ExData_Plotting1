  #PLOT 2
  # Download the data
myzip = "exdata_data_household_power_consumption.zip"
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile=myzip,method="curl")
unzip(myzip)
  #read the data
data <- read.csv("./household_power_consumption.txt", sep = ";",colClasses ="character") 
  # close the connections to eliminate the warning.
closeAllConnections() 
  #limit the data to the timeframe we are interested in
data <- subset(data, Date == "2/2/2007" | Date == "1/2/2007") 
  #Format the data and add it to the dataframe.
dt <- paste(data$Date, data$Time)
dor <- strptime(dt, "%d/%m/%Y %T")
data <- cbind(data, dor)
  # set the device and output size
png(filename="plot2.png", width=480, height=480, units= "px") # set the device and output size
  # Run the plot function
plot( data$dor, as.numeric(data$Global_active_power), type="l", xlab="", ylab="Global Active Power (kilowatts)")
  #Release the device.
dev.off() #Release the device.