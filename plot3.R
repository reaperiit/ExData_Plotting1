library(data.table)

if(!file.exists("./data")){dir.create("./data")}
fileUrl<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile = "./data/Dataset.zip")
unzip(zipfile = "./data/Dataset.zip" ,exdir = "./data")

data <- read.table(file = "./data/household_power_consumption.txt", sep = ";",na.strings = "?",header = T)
data_subset<- data[data$Date %in% c("1/2/2007","2/2/2007"),]

#str(data_subset)

datetime <- strptime(paste(data_subset$Date, data_subset$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

png("plot3.png", width = 480,height = 480)
plot(datetime  , data_subset$Sub_metering_1,type = "l",ylab = "Energy Sub metering", xlab = " ")
lines(datetime , data_subset$Sub_metering_2,type="l", col = "red")
lines(datetime , data_subset$Sub_metering_3,type="l", col = "blue")
legend("topright", c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"),lty = 1,
       lwd = 2.5,col=c("black","red","blue"))
dev.off()
