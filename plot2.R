source('./loadData.R')

plot2 <- function (savedFile = "./data/household_power_consumption.txt") {
        
        ## Read data from the dataset and subset it in order to keep only 2 days as required
        data <- loadData(savedFile)
        
        ## Set only one plot layout
        par(mfrow = c(1, 1)) 
        
        ## Draw the plot 
        with(data, 
             plot(x = timestamp, 
                  y = Global_active_power, 
                  type="l", 
                  xlab = "", 
                  ylab = "Global Active Power (kilowatts)"))
               
        ## Copy the plot as PNG image
        dev.copy(png, file = "./plot2.png")
        
        ## Close PNG device
        dev.off()
}