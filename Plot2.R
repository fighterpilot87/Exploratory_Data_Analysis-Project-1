hpcfile <- read.table(
  "household_power_consumption.txt",
  sep = ";", header = TRUE)

hpc <- hpcfile[hpcfile$Date == "1/2/2007" | hpcfile$Date == "2/2/2007", ]
hpc$DT <- paste(hpc$Date, hpc$Time)
hpc[, 1] <- hpc$DT
hpc <- subset(hpc, select = -c(DT, Time))
hpc$Date <- strptime(hpc$Date, format = "%d/%m/%Y %H:%M:%S")
hpc[is.na(hpc)] <- 0

for(i in 2:ncol(hpc)){
  hpc[,i] <- as.numeric(levels(hpc[,i])[hpc[,i]])
}


with(hpc, plot(Date, Global_active_power, type = "l", 
               xlab = "", ylab = "Global Active Power (kilowatts)"))

dev.copy(png, file = "Plot2.png")
dev.off()