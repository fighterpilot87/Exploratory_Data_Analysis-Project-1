hpcfile <- read.table(
  "household_power_consumption.txt",
  sep = ";", header = TRUE)

hpc <- hpcfile[hpcfile$Date == "1/2/2007" | hpcfile$Date == "2/2/2007", ]
hpc$DT <- paste(hpc$Date, hpc$Time)
hpc[, 1] <- hpc$DT
hpc <- subset(hpc, select = -c(DT, Time))
hpc$Date <- strptime(hpc$Date, format = "%d/%m/%Y %H:%M:%S")

for(i in 2:ncol(hpc)){
  hpc[,i] <- as.numeric(levels(hpc[,i])[hpc[,i]])
}

hist(hpc$Global_active_power, col = "red", 
     xlab = "Global Active Power", 
     main = "Global Active Power")

dev.copy(png, file = "Plot1.png")
dev.off()
