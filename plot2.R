# Programing project #1 Exploratory Data 

# The loadAndCLean.R source file must be in the same folder as this file
source("loadAndClean.R")
data <- loadAndClean()

# The data are cleaner and in the right range
png("plot2.png", width = 480, height = 480)
with(data, plot(DateTime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab =""))
dev.off()