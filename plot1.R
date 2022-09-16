install.packages("vroom")
install.packages("dplyr")
library(vroom)
library(dplyr)

raw_data <- vroom("raw_data/household_power_consumption.txt", col_types = list("?", "c", "d", "d", "d", "d", "d", "d", "d"))
feb_data <- raw_data %>% filter(Date == "1/2/2007" | Date == "2/2/2007")
hist(as.numeric(feb_data$Global_active_power), col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.copy(png,filename="plot1.png", height=480, width=480)
dev.off()

