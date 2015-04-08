#reads raw data file and insert into variable
hpcfile <- read.table(
  "household_power_consumption.txt",
  sep = ";", header = TRUE)

#subset of data (takes a portion of file and create a new variable)
hpc <- hpcfile[hpcfile$Date == "1/2/2007" | hpcfile$Date == "2/2/2007", ]

#remove large data from memory
rm(hpcfile)

#combine Date and Time into single column
hpc$DT <- paste(hpc$Date, hpc$Time)
hpc[, 1] <- hpc$DT
hpc <- subset(hpc, select = -c(DT, Time))
hpc$Date <- strptime(hpc$Date, format = "%d/%m/%Y %H:%M:%S")

#Convert factor values to numeric
for(i in c(2, 3, 4, 6, 7)){
  hpc[,i] <- as.numeric(levels(hpc[,i])[hpc[,i]])
}

#Convert all NA into 0s
hpc[is.na(hpc)] <- 0

#create 2 rows and 2 columns of plot space
par(mfrow = c(2,2))

with(hpc, {
  #1st plot
  plot(Date, Global_active_power, type = "l", 
               xlab = "", ylab = "Global Active Power (kilowatts)") 
  
  #2nd plot
  plot(Date, Voltage, type = "l", 
       xlab = "datetime", ylab = "Voltage")
  
  #3rd plot
  plot(hpc$Date, hpc$Sub_metering_1, type = "l", yaxt = "n",
     xlab = "", ylab = "Energy sub metering")
  axis(2, at = seq(0, 30, by = 10), las = 2)
  lines(hpc$Date, hpc$Sub_metering_2, col = "red")
  lines(hpc$Date, hpc$Sub_metering_3, col = "blue")
  legend('topright', lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", 
                  "Sub_metering_2", 
                  "Sub_metering_3"))
  
  #4th plot
  plot(Date, Global_reactive_power, type = "l", 
       xlab = "datetime")

})

dev.copy(png, file = "Plot4.png")
dev.off()