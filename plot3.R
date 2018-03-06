## Dataset(Electric power consumption) simplified as EPC

library("read.table")
## loading dateset
EPC<- read.table("./EDA_W1/household_power_consumption.txt",  
                 stringsAsFactors = FALSE, sep =";", header=TRUE)

## convert to Date class and subset
EPC$Date <- as.Date(EPC$Date, "%d/%m/%Y")
subset_EPC <- subset(EPC, Date== "2007-02-01"| Date=="2007-02-02")
## create column datetime by combining Date and Time columns
subset_EPC$datetime <- strptime(paste(subset_EPC$Date,subset_EPC$Time), 
                                "%Y-%m-%d %H:%M:%S")

## change variables' classes to make plot
subset_EPC$Sub_metering_1 <- as.numeric(subset_EPC$Sub_metering_1)
subset_EPC$Sub_metering_2 <- as.numeric(subset_EPC$Sub_metering_2)
subset_EPC$Sub_metering_3 <- as.numeric(subset_EPC$Sub_metering_3)
subset_EPC$datetime <- as.POSIXct(subset_EPC$datetime)
## plot step by step(3 intotal), and add annotation(legend) also
png("plot3.png", width=480, height=480)
with(subset_EPC,plot(datetime, Sub_metering_1, type="l",xlab="",
                     ylab="Energy sub metering"))
lines(subset_EPC$datetime,subset_EPC$Sub_metering_2, col="red")
lines(subset_EPC$datetime,subset_EPC$Sub_metering_3, col="blue")
legend("topright", lty=1, col=c("black", "red", "blue"),
legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
