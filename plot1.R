  #PLOT 1
  #Download and extract data
myzip = "exdata_data_household_power_consumption.zip"
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile=myzip,method="curl")
unzip(myzip)
  # Read the data
data <- read.csv("./household_power_consumption.txt", sep = ";",colClasses ="character") 
  # close the connections to eliminate the warning.
closeAllConnections()
  #limit the data to the timeframe we are interested in
data <- subset(data, Date == "2/2/2007" | Date == "1/2/2007") 
  # set the device and output size
png(filename="plot1.png", width=480, height=480, units= "px")
  # Run the hist function
hist(as.numeric(data$Global_active_power), xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")  
  #Release the device.
dev.off() 