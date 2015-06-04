source('./loadData.R')

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