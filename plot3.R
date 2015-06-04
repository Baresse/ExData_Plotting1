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
plot3 <- function (savedFile = "./data/household_power_consumption.txt") {
        
        ## Read data from the dataset and subset it in order to keep only 2 days as required
        data <- loadData(savedFile)
        
        ## Set only one plot layout
        par(mfrow = c(1, 1)) 
        
        ## Draw the plot 
        with(data, 
             plot(x = timestamp, 
                  y = Sub_metering_1, 
                  type="l", 
                  xlab = "", 
                  ylab = "Energy sub metering"))
        
        ## Add the second line on the plot
        with(data, 
             lines(x = timestamp, 
                   y = Sub_metering_2, type="l", col = "red"))
        
        ## Add the third line on the plot
        with(data, 
             lines(x = timestamp, 
                   y = Sub_metering_3, type="l", col = "blue"))
        
        ## Add the top right legend
        legend("topright", 
               lty = c(1, 1, 1),
               pch = NA, 
               col = c("black", "red", "blue"), 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        
        ## Copy the plot as PNG image
        dev.copy(png, file = "./plot3.png")
        
        ## Close PNG device
        dev.off()
}