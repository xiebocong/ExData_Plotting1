## Dataset(Electric power consumption) simplified as EPC

library("read.table")
## loading dateset
EPC<- read.table("./EDA_W1/household_power_consumption.txt",  
                 stringsAsFactors = FALSE, sep =";", header=TRUE)

## convert to Date class and subset
EPC$Date <- as.Date(EPC$Date, "%d/%m/%Y")
subset_EPC <- subset(EPC, Date== "2007-02-01"| Date=="2007-02-02")
##create column datetime by combing Date and Time columns
subset_EPC$datetime <- strptime(paste(subset_EPC$Date,subset_EPC$Time), 
                                "%Y-%m-%d %H:%M:%S")

##change all variables' class to make plot
subset_EPC$Global_active_power <- as.numeric(subset_EPC$Global_active_power)
subset_EPC$Global_reactive_power <- as.numeric(subset_EPC$Global_reactive_power)
subset_EPC$Voltage <- as.numeric(subset_EPC$Voltage)
subset_EPC$Sub_metering_1 <- as.numeric(subset_EPC$Sub_metering_1)
subset_EPC$Sub_metering_2 <- as.numeric(subset_EPC$Sub_metering_2)
subset_EPC$Sub_metering_3 <- as.numeric(subset_EPC$Sub_metering_3)
subset_EPC$datetime <- as.POSIXct(subset_EPC$datetime)
## plot
png("plot4.png", width=480, height=480)
# set up layout to make four plots, column-wise
par(mfcol=c(2,2), mar=c(4,4,1,1))
# figure1
with(subset_EPC,plot(datetime, Global_active_power, type="l",xlab="",
                     ylab="Global Active Power"))
# figure2
with(subset_EPC,plot(datetime, Sub_metering_1, type="l",xlab="",
                     ylab="Energy sub metering"))
lines(subset_EPC$datetime,subset_EPC$Sub_metering_2, col="red")
lines(subset_EPC$datetime,subset_EPC$Sub_metering_3, col="blue")
legend("topright", lty=1, col=c("black", "red", "blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       ,cex=0.7,bty="n") # remove border and zoom out 
#figure3
with(subset_EPC,plot(datetime, Voltage, type="l",xlab="datetime",
                     ylab="Voltage"))
#figure4
with(subset_EPC,plot(datetime, Global_reactive_power, type="l",xlab="datetime",
                     ylab="Global_reactive_power"))
dev.off()
