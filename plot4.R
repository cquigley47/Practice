setwd("~/RWD")

library(data.table)
library(date)
library(dplyr)


### Reading entire dataset since it is pretty fast (about 20 sec.)

epc <- NULL

### header=TRUE insures numerics come in as numeric
### still have to deal with date and time.

epc <- read.table("./data/household_power_consumption.txt",sep=";", header=TRUE, na.strings="?")


### Fix Date

epc$Date <- as.Date(epc$Date, format = "%d/%m/%Y")

### Subset dates

d1 <- as.Date("2007-02-01")
d2 <- as.Date("2007-02-02")
epc <- subset(epc, epc$Date %in% c(d1,d2))



### Fix Time - Have to combine with Date first

temp <- paste(epc$Date, epc$Time)
epc$Time <- strptime(temp, format = "%Y-%m-%d %H:%M:%S")


### Plots 4

png(file="plot4.jpg", bg="transparent", width=480, height=480)

par(mfrow = c(2,2))

### Plot 1,1 - Time vs Global Active Power

with(epc, plot(Time, Global_active_power, type="l", xlab="", 
               ylab="Global Active Power"))

### Plot 1,2 - Time vs Voltage

with(epc, plot(Time, Voltage, type="l", xlab="datetime", 
               ylab="Voltage"))

### Plot 2,1 - Sub Metering vs. time

with(epc, plot(Time, Sub_metering_1, type="l", xlab="", 
               ylab="Energy sub metering"))
with(epc, lines(Time, Sub_metering_2, col="red"))
with(epc, lines(Time, Sub_metering_3, col="blue"))
legend("topright", lty=c(1,1,1),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), bty="n")


### Plot 2,2 - Time vs. Global reactive power

with(epc, plot(Time, Global_reactive_power, type="l", xlab="datetime"))
  
     
dev.off()

