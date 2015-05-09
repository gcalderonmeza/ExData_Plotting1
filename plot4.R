# Programing project #1 Exploratory Data 

# The loadAndCLean.R source file must be in the same folder as this file
source("loadAndClean.R")
data <- loadAndClean()

# The data are cleaner and in the right range
png("plot4.png", width = 480, height = 480)
par(mfcol = c(2,2))

# First plot
with(data, plot(DateTime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab =""))

# Second plot
with(data, plot(DateTime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab =""))
with(data, lines(DateTime, Sub_metering_2, col="red"))
with(data, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = names(data)[6:8], bty = "n")

# Third plot
with(data, plot(DateTime, Voltage, type = "l", ylab = "Voltage"))

# Fouth plot
with(data, plot(DateTime, Global_reactive_power, type = "l", ylab = "Global_reactive_power"))

dev.off()