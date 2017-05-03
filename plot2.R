data <- read.table("household_power_consumption.txt", sep=";", header=TRUE)
colnames(data) <-c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")


data$Date <- as.Date(strptime(data$Date,"%e/%m/%Y"))

data1 <- data[ which(data$Date == "2007-02-01" | data$Date == "2007-02-02"), ]

data1$DT <- as.POSIXct(paste(data1$Date,data1$Time), format="%Y-%m-%d %H:%M:%S")

data1$Global_active_power <- as.numeric(as.character(data1$Global_active_power))

data1$Sub_metering_1 <- as.numeric(as.character(data1$Sub_metering_1))
data1$Sub_metering_2 <- as.numeric(as.character(data1$Sub_metering_2))
data1$Sub_metering_3 <- as.numeric(as.character(data1$Sub_metering_3))

data1$Voltage <- as.numeric(as.character(data1$Voltage))
data1$Global_reactive_power <- as.numeric(as.character(data1$Global_reactive_power))

png(file = "plot2.png", width = 480, height = 480, units = "px")
plot(data1$DT, data1$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
