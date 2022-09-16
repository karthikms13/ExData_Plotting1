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

par(mfrow=c(1,1))

with(feb_data, plot(DateTime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))
dev.copy(png,filename="plot2.png", height=480, width=480)
dev.off()
