# Programing project #1 Exploratory Data 

# The loadAndCLean.R source file must be in the same folder as this file
source("loadAndClean.R")
data <- loadAndClean()

# The data are cleaner and in the right range
png("plot3.png", width = 480, height = 480)
with(data, plot(DateTime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab =""))
with(data, lines(DateTime, Sub_metering_2, col="red"))
with(data, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = names(data)[6:8])
dev.off()