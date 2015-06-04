source('./loadData.R')

plot1 <- function (savedFile = "./data/household_power_consumption.txt") {

        ## Read data from the dataset and subset it in order to keep only 2 days as required
        data <- loadData(savedFile)
       
        ## Set only one plot layout
        par(mfrow = c(1, 1)) 
        
        ## Draw the plot 
        hist(data$Global_active_power, 
             main = "Global Active Power", 
             xlab = "Global Active Power (kilowatts)", 
             col = "red")

        ## Copy the plot as PNG image
        dev.copy(png, file = "./plot1.png")
        
        ## Close PNG device
        dev.off()
}