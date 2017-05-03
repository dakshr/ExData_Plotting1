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

png(file = "plot4.png", width = 480, height = 480, units = "px")

par(mfrow = c(2,2))
with(data1, {
  plot(DT, Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")
  plot(DT, Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
  with(data1, plot(DT, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
  with(data1, lines(DT, Sub_metering_1, col = "black"))
  with(data1, lines(DT, Sub_metering_2, col = "red"))
  with(data1, lines(DT, Sub_metering_3, col = "blue"))
  legend("topright", lty = c(1,1,1), col = c("black", "red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(DT, Global_reactive_power, type = "l", xlab = "")
})

dev.off()