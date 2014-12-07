######################################################################################
# plot2.R
#
# Coursera project: Exploratory Data Analysis
# Date:             Dec 7 2014
# Run:              create a source and call the function: plot2 ()
# 
# Functionality:
# 1. Read the data file
# 2. Create a specified plot
# 3. Outputs the plot to a png file 480*480 pixcels
# 
########################################################################


#---------- Function download()  --------------------------------------
# Function: Download the exercise file, filter and clean data
# Steps: 
#   1) Download the zip file for this exercise to ./data/getdata.zip, and
#      if not exist, unzip the fle to "./data/household_power_consumption.txt"
#   2) Read the txt file (fixing missings and column types)
#   3) Filter data for 2007-02-01 and 2007-02-02 only
#   4) Convert Date/Time variables  to Date/Time classes in R
# Return: Data frame of date, time and 7 numerals ready for analysis
#---------------------------------------------------------------------

download <- function () {
  if (!file.exists("data")) { 
    dir.create("data") 
  }    
  file.name <-"./data/household_power_consumption.txt"
  if (!file.exists(file.name)) {
    file.url <- ("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")
    download.file (file.url, destfile = "./data/getdata.zip")
    unzip("./data/getdata.zip", exdir="./data")
  }
  data <- read.table(file.name, header=TRUE, sep=";", na.strings = c("NA","","?"), 
                     colClasses=c("character","character",rep("numeric",7)), 
                     stringsAsFactors = FALSE) 
  data <- data [ (data$Date == "1/2/2007") | (data$Date == "2/2/2007"),]
  data$Time <- strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S", tz="EST")
  data$Date <- as.Date(data$Date, "%d/%m/%Y")
  data
}

plot2 <- function (d = download() ) {
  file.plot <- "plot2.png"
  png(filename = file.plot,width = 480, height = 480, bg="transparent")
  
  with(d, plot(Time, Global_active_power, xlab="", ylab = "Global Active Power (kilowatts)", bg="transparent", lty=1, lwd=1, pch="."))
  with(d, lines(Time, Global_active_power, xlab="", ylab = "Global Active Power (kilowatts)", bg="transparent"))
  
  dev.off()
  file.plot
}
