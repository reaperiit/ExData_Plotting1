library(data.table)

if(!file.exists("./data")){dir.create("./data")}
fileUrl<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile = "./data/Dataset.zip")
unzip(zipfile = "./data/Dataset.zip" ,exdir = "./data")

data <- read.table(file = "./data/household_power_consumption.txt", sep = ";",na.strings = "?",header = T)
data_subset<- data[data$Date %in% c("1/2/2007","2/2/2007"),]

#str(data_subset)
data_subset$Date <- as.Date(data_subset$Date, "%d/%m/%Y")
data_subset<- cbind(data_subset, "DateTime" =  as.POSIXct(paste(data_subset$Date, data_subset$Time)))

png("plot2.png", height = 480, width = 480)
plot(data_subset$Global_active_power ~ data_subset$DateTime, xlab = "" ,type="l",
     ylab = "Global Active Power(in kilowatts)")
dev.off()
