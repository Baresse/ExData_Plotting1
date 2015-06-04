source('./loadData.R')

plot4 <- function (savedFile = "./data/household_power_consumption.txt") {
        
        ## Read data from the dataset and subset it in order to keep only 2 days as required
        data <- loadData(savedFile)
       
        par(mfrow = c(2, 2)) 
        
        ## Draw the plots 
        with(data, {
                plot(x = timestamp, y = Global_active_power, type="l",  xlab = "",  ylab = "Global Active Power (kilowatts)")
                
                plot(x = timestamp, y = Voltage, type="l", xlab = "datetime")
                
                plot(x = timestamp, y = Sub_metering_1, type="l",  xlab = "", ylab = "Energy sub metering")
                lines(x = timestamp, y = Sub_metering_2, type="l", col = "red")
                lines(x = timestamp, y = Sub_metering_3, type="l", col = "blue")
                legend("topright", lty = c(1, 1, 1), pch = NA, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
                
                plot(x = timestamp, y = Global_reactive_power, type="l", xlab = "datetime")
        })
        
       
        ## Copy the plot as PNG image
        dev.copy(png, file = "./plot4.png")
        
        ## Close PNG device
        dev.off()
}