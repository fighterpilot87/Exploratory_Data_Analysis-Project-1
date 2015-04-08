hpcfile <- read.table(
  "household_power_consumption.txt",
  sep = ";", header = TRUE)

hpc <- hpcfile[hpcfile$Date == "1/2/2007" | hpcfile$Date == "2/2/2007", ]
hpc$DT <- paste(hpc$Date, hpc$Time)
hpc[, 1] <- hpc$DT
hpc <- subset(hpc, select = -c(DT, Time))
hpc$Date <- strptime(hpc$Date, format = "%d/%m/%Y %H:%M:%S")

#Convert factor values to numeric
for(i in c(2, 3, 4, 6, 7)){
  hpc[,i] <- as.numeric(levels(hpc[,i])[hpc[,i]])
}
hpc[is.na(hpc)] <- 0

plot(hpc$Date, hpc$Sub_metering_1, type = "l", yaxt = "n",
               xlab = "", ylab = "Energy sub metering")
axis(2, at = seq(0, 30, by = 10), las = 2)
lines(hpc$Date, hpc$Sub_metering_2, col = "red")
lines(hpc$Date, hpc$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       cex = .75)


dev.copy(png, file = "Plot3.png")
dev.off()