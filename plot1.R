## Dataset(Electric power consumption) simplified as EPC

library("read.table")
## loading dateset
EPC<- read.table("./EDA_W1/household_power_consumption.txt",  
                 stringsAsFactors = FALSE, sep =";", header=TRUE)

## convert to Date class and subset
EPC$Date <- as.Date(EPC$Date, "%d/%m/%Y")
subset_EPC <- subset(EPC, Date== "2007-02-01"| Date=="2007-02-02")

##change variable class to make plot
subset_EPC$Global_active_power <- as.numeric(subset_EPC$Global_active_power)
png("plot1.png", width=480, height=480)
hist(subset_EPC$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col = "Red")
dev.off()
