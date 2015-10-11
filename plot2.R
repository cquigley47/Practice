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


### Plot 2 - Global_actice_power (KW) vs Day of Week

png(file="plot2.jpg", bg="transparent", width=480, height=480)

with(epc, plot(Time, Global_active_power, type="l", xlab="", lwd=1.5,
        ylab="Global Active Power (kilowatts)", font=2, font.lab=2))

dev.off()

