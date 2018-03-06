## Dataset(Electric power consumption) simplified as EPC

library("read.table")
## loading dateset
EPC<- read.table("./EDA_W1/household_power_consumption.txt",  
                 stringsAsFactors = FALSE, sep =";", header=TRUE)

## convert Date class and subset
EPC$Date <- as.Date(EPC$Date, "%d/%m/%Y")
subset_EPC <- subset(EPC, Date== "2007-02-01"| Date=="2007-02-02")
##create column datetime
subset_EPC$datetime <- strptime(paste(subset_EPC$Date,subset_EPC$Time), 
                                "%Y-%m-%d %H:%M:%S")

##change variable class to make plot
subset_EPC$Global_active_power <- as.numeric(subset_EPC$Global_active_power)
subset_EPC$datetime <- as.POSIXct(subset_EPC$datetime)
## plot
png("plot2.png", width=480, height=480)
with(subset_EPC,plot(datetime, Global_active_power, type="l",xlab="",
ylab="Global Active Power (kilowatts)"))
dev.off()