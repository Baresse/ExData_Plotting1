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
plot1 <- function (savedFile = "./data/household_power_consumption.txt") {

        ## Read data from the dataset and subset it in order to keep only 2 days as required
        data <- loadData(savedFile)
       
        ## Set only one plot layout
        par(mfrow = c(1, 1)) 
        
        ## Generate the plot as PNG image with the exact size and transparent background
        png('./plot1.png',width=504,height=504,units="px",bg = "transparent")
        
        ## Draw the plot 
        hist(data$Global_active_power, 
             main = "Global Active Power", 
             xlab = "Global Active Power (kilowatts)", 
             col = "red")

        ## Close PNG device
        dev.off()
}