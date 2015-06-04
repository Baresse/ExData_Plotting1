library(data.table)

##
## Function used to load the dataset
##
loadData <- function (savedFile = "./data/household_power_consumption.txt") {
        
        ## Set to C Locale
        Sys.setlocale('LC_TIME', 'C')
        
        ## Read file into a data.table
        DT <- fread(savedFile, na.strings="?", colClasses = "characters")
        
        ## Subset dataset
        data <- subset(DT, DT$Date == "1/2/2007" | DT$Date  == "2/2/2007")
        
        ## Convert the Date column into a POSIXct class
        data$timestamp <- paste(data$Date, data$Time)
        data$timestamp <- as.POSIXct(strptime(data$timestamp, "%d/%m/%Y %H:%M:%S"))
        
        ## Convert into numeric the parameters
        data$Global_active_power <- as.numeric(data$Global_active_power)
        data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
        data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
        data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
        data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
        data$Voltage <- as.numeric(data$Voltage)
        
        data
} 

##
## Function used to generate the plot
##
plot4 <- function (savedFile = "./data/household_power_consumption.txt") {
        
        ## Read data from the dataset and subset it in order to keep only 2 days as required
        data <- loadData(savedFile)
       
        ## Generate the plot as PNG image with the exact size and transparent background
        png('./plot4.png',width=504,height=504,units="px",bg = "transparent")
        
        par(mfrow = c(2, 2)) 
        
        ## Draw the plots 
        with(data, {
                plot(x = timestamp, y = Global_active_power, type="l",  xlab = "",  ylab = "Global Active Power (kilowatts)")
                
                plot(x = timestamp, y = Voltage, type="l", xlab = "datetime")
                
                plot(x = timestamp, y = Sub_metering_1, type="l",  xlab = "", ylab = "Energy sub metering")
                lines(x = timestamp, y = Sub_metering_2, type="l", col = "red")
                lines(x = timestamp, y = Sub_metering_3, type="l", col = "blue")
                legend("topright", bty="n", lty = c(1, 1, 1), pch = NA, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
                
                plot(x = timestamp, y = Global_reactive_power, type="l", xlab = "datetime")
        })
                
        ## Close PNG device
        dev.off()
}