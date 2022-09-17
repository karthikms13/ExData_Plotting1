# Install the packages vroom and dplyr
# vroom - lets us read a large file faster (it doesn't load the whole file but lazily loads it when parts of it are queried)
# dplyr - lets us query the data using friendlier methods like select, filter, mutate etc
install.packages("vroom")
install.packages("dplyr")
library(vroom)
library(dplyr)

# download the file and unzip it 
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="household_power_consumption.zip")
unzip("household_power_consumption.zip")

# read the file with vroom
raw_data <- vroom("household_power_consumption.txt", col_types = list("?", "c", "d", "d", "d", "d", "d", "d", "d"))

# fetch only the data matching Feb 1 and Feb 2 of 2007
feb_data <- raw_data %>% filter(Date == "1/2/2007" | Date == "2/2/2007")

# add a datetime column by combining date and time columns 
feb_data <- feb_data %>% mutate(Date = as.Date(Date, format="%d/%m/%Y")) %>% mutate(DateTime = as.POSIXct(paste(Date, Time)))

# Use mfrow to create a 4 segments 
par(mfrow=c(2,2))

with(feb_data, plot(DateTime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "", cex=0.8))

with(feb_data, plot(DateTime, Voltage, type = "l", ylab = "Voltage", xlab = "datetime", cex=0.8))

with(feb_data, plot(DateTime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", cex=0.8, col="black"))
with(feb_data, lines(DateTime, Sub_metering_2, type = "l", col = "red"))
with(feb_data, lines(DateTime, Sub_metering_3, type = "l", col = "blue"))

legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.2)

with(feb_data, plot(DateTime, Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime",cex=0.8))

# Copy the plot to png
dev.copy(png,filename="plot4.png", height=480, width=480)
dev.off()
