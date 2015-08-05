## Coursera Assignment 1
## Date: Thu Jul  9 12:13:12 2015
## Developed by Konstantin
## before you run this: set your working directory
## NOTE: Your data should be located in the data subdirectory

## Plot 3

## load required packages
library(sqldf) ## sql query language
library(lubridate) ## date-time conversion

## loads the data using sql query language
## places data into an object called data
data <- read.csv.sql(file = "./data/household_power_consumption.txt",
                     sql = "SELECT * FROM file WHERE Date IN ('1/2/2007', '2/2/2007')",
                     header = TRUE,
                     sep = ";")

data$Date <- with(data, dmy(Date)) ## converts date into POSIXct
data$Time2 <- with(data, strptime(Time, '%H:%M:%S')) ## you might want to convert the data as well, 
##I didn't care about this in the curent script


## Generates plot 3
data$tracker <- seq(1:2880)

with(data, {
        plot(tracker, Sub_metering_1,
             type = 'n',
             xlab = '',
             ylab = 'Energy sub metering',
             xaxt = 'n')
})

axis(side = 1, at = c(0, 1400, 2880), labels = c('Thu', 'Fri', 'Sat'))

with(data, {
        lines(tracker, Sub_metering_1)
        lines(tracker, Sub_metering_2, col = 'red')
        lines(tracker, Sub_metering_3, col = 'blue')
})

legend('topright', lty  = 1, 
       col = c('black', 'blue', 'red'), 
       legend = c('Sub_metering_1', 
                  'Sub_metering_2', 
                  'Sub_metering_3'),
       border = 'black')

dev.copy(png,'./plots/plot3.png')
dev.off()