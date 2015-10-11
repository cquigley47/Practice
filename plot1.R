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

### Lets make some plots!

### Plot 1 - Bar Chart of Global_actice_power



png(file="plot1.jpg", bg="transparent", width=480, height=480)

with(epc, hist(Global_active_power, main="Global Active Power", col="red", lwd=1,
      xlab="Global Active Power (killowatts)",font=2, font.lab=2))

### dev.copy(png, file="plot1.png")
dev.off()

