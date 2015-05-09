# Programing project #1 Exploratory Data 

# The loadAndCLean.R source file must be in the same folder as this file
source("loadAndClean.R")
data <- loadAndClean()

# The data are cleaner and in the right range
png("plot1.png", width = 480, height = 480)
with(data, hist(Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col="red"))
dev.off()