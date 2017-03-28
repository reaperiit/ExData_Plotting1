library(data.table)

if(!file.exists("./data")){dir.create("./data")}
fileUrl<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile = "./data/Dataset.zip")
unzip(zipfile = "./data/Dataset.zip" ,exdir = "./data")

data <- read.table(file = "./data/household_power_consumption.txt", sep = ";",na.strings = "?",header = T)
data_subset<- data[data$Date %in% c("1/2/2007","2/2/2007"),]

#str(data_subset)

datetime <- strptime(paste(data_subset$Date, data_subset$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

png("plot4.png",height = 480,width = 480)
par(mfrow = c(2,2))

plot(datetime, data_subset$Global_active_power, type="l",xlab = "",
     ylab = "Global Active Power",cex=0.2)
plot(datetime, data_subset$Voltage, type = "l", xlab = "datetime",ylab="Voltage")

plot(datetime, data_subset$Sub_metering_1,type = "l",ylab = "Energy Sub Metering",xlab = "")
lines(datetime, data_subset$Sub_metering_2, type = "l",col="red")
lines(datetime, data_subset$Sub_metering_3, type = "l",col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"),lty = 1,lwd=2.5)

plot(datetime, data_subset$Global_reactive_power, type = "l",xlab = "datetime",ylab = "Global Reactive Power")


dev.off()
