  #PLOT 4
  # add required library
library("data.table", lib.loc="/Library/Frameworks/R.framework/Versions/3.0/Resources/library")
  # Download the data
myzip = "exdata_data_household_power_consumption.zip"
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile=myzip,method="curl")
unzip(myzip)
  # Read the data
data <- read.csv("./household_power_consumption.txt", sep = ";",colClasses ="character") 
  # close the connections to eliminate the warning.
closeAllConnections()
  #limit the data to the timeframe we are interested in
data <- subset(data, Date == "2/2/2007" | Date == "1/2/2007")
  #Format the data and add it to the dataframe.
dt <- paste(data$Date, data$Time)
dor <- strptime(dt, "%d/%m/%Y %T")
data <- cbind(data, dor)
  # make a dataframe of the date and the sub_metering attributes combined with a type field.
df <- data.frame(data$dor, as.numeric(data$Sub_metering_1), "1")
df2 <- data.frame(data$dor, as.numeric(data$Sub_metering_2), "2")
df3 <- data.frame(data$dor, as.numeric(data$Sub_metering_3), "3")
setnames(df, c("datetime", "submeteramt", "submeter"))
setnames(df2, c("datetime", "submeteramt", "submeter"))
setnames(df3, c("datetime", "submeteramt", "submeter"))
df <- rbind(df, df2)
df <- rbind(df, df3)
  # set the device and output size
png(filename="plot4.png", width=480, height=480, units= "px")
  # format the output plot
par(mfrow = c(2,2))
  #first plot
plot( data$dor, as.numeric(data$Global_active_power), type="l", xlab="", ylab="Global Active Power")
  #second plot
plot( data$dor, as.numeric(data$Voltage), type="l", xlab="datetime", ylab="Voltage")
  # third plot
plot(df$datetime, df$submeteramt, type="n", xlab="", ylab="Energy sub metering")
points(df$datetime[df$submeter=="1"], df$submeteramt[df$submeter=="1"], col="black", type="l")
points(df$datetime[df$submeter=="2"], df$submeteramt[df$submeter=="2"], col="red", type="l")
points(df$datetime[df$submeter=="3"], df$submeteramt[df$submeter=="3"], col="blue", type="l")
  # forth plot
plot( data$dor, as.numeric(data$Global_reactive_power), type="l", xlab="datetime", ylab="Global_reactive_power")
  #release the device
dev.off()