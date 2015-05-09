# Programing project #1 Exploratory Data 
#
# This file is general and is sourced by all the other 4 files
#
# The functions here load and clean the data in a basic way
#
# I am using one more file (this one) than specified, because 
#   I did not want to repeat code in all the 4 files.
#
# The function loadAndClean is called from all the other script files to load and
#   clean the data before creating the plots

# Concatenates two fators (one with the date and one with the time) into a single string
makeItString <- function (date, time) {
  paste(as.character(date), as.character(time))
}

# Convers two factors (one with the date and one with the time) into a DateTime
convertDate <- function(date, time) {
  strptime(makeItString(date, time), "%d/%m/%Y %H:%M:%S")
}

# Converts a string into a date/time
convertDate1 <- function(dateTimeStr) {
  strptime(dateTimeStr, "%d/%m/%Y %H:%M:%S")
}

# Loads and cleans the data
loadAndClean <- function ()
{
  if (!file.exists('data/household_power_consumption.txt')) {
    stop(paste('File does not exist:', 'data/household_power_consumption.txt'))
  }
  
  data_0 <- read.csv('data/household_power_consumption.txt', header =TRUE, sep = ";",na.strings = "?", nrows = 100)
  head(data_0)
  
  namesToUse <- names(data_0)
  
  # Convert Date and Time into Date/Time object
  firstDate <- convertDate(data_0[1,"Date"], data_0[1,"Time"])
  
  # First Date/Time is 2006/12/16 17:24:00
  # It seems like there are samples every minute (as stated in the description)
  
  data_1 <- read.csv('data/household_power_consumption.txt', header =TRUE, sep = ";",na.strings = "?", skip = 2060000, col.names = namesToUse)
  tail(data_1)
  
  # Last Data/Time is 2010/11/26 21:02:00
  # It seems like there are samples every minute (as stated in the description)
  
  #
  # I need to get data for 2007-02-01 and 2007-02-02
  # I could approximate the date/time range using nrows and skip
  #
  
  firstDateNeeded <- strptime("2007-02-01 00:00:00", "%Y-%m-%d %H:%M:%S")
  lastDateNeeded <- strptime("2007-02-02 23:59:00", "%Y-%m-%d %H:%M:%S")
  
  daysToSkip <- as.numeric(firstDateNeeded - firstDate)
  rowsToSkip <- daysToSkip * 24 * 60 - 1
  rowsToRead <- 2 * 24 * 60 + 2
  
  # 
  # However, a simple read.csv works fine in my computer, but it takes some time
  # data <- read.csv('data/household_power_consumption.txt', header =TRUE, sep = ";",na.strings = "?")
  # But I am using the cmputed range and then testing for correctness
  
  data <- read.csv('data/household_power_consumption.txt', header =TRUE, sep = ";",na.strings = "?", skip = rowsToSkip, nrows = rowsToRead, col.names = namesToUse)
  firstReadDate <- convertDate(data[1,"Date"], data[1,"Time"])
  lastDateRead <- convertDate(data[nrow(data), "Date"], data[nrow(data), "Time"])
  
  if (firstReadDate < firstDateNeeded) {
    data <- data[2:nrow(data),]
  } else {
    head(data)
    stop("Data are not in range")
  }
  
  if (lastDateRead > lastDateNeeded) {
    data <- data[1:nrow(data) -1,]
  } else {
    tail(data)
    stop("Data are not in range")
  }

  ## Conver the Date and Time to a single Date/Time
  datesStr <- mapply(makeItString, data$Date, data$Time)
  dates <- convertDate1(datesStr)
  data <- cbind("DateTime" = dates, data[,3:9])
}
