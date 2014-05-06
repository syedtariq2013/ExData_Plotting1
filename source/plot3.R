plot3 <- function() {
  #----------------------------------------------------------------------------
  # Read from the file records corresponding to dates '1/2/2007' and '2/2/2007'
  # and create a data frame
  #----------------------------------------------------------------------------
  require("sqldf")
  #setwd("/home/syed/exploratorydataanalysis/ExData_Plotting1")
  mySql <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
  myFile <- "../household_power_consumption.txt"
  dfData <- read.csv2.sql(myFile,mySql)
  #----------------------------------------------------------------------------
  # Next, build a new frame after converting the date and time fields to POSIX
  # Also, combine the date and time columns into a single DateTime column
  #----------------------------------------------------------------------------
  # combine date and time into one vector. Format: %d/%m/%Y %T
  vDateTime <- paste(dfData[[1]],dfData[[2]]) 
  # convert to Posix
  vDateTime <- strptime(vDateTime,format="%d/%m/%Y %T")
  # create new data frame
  dfNewData <- data.frame(vDateTime,dfData[[3]],dfData[[4]],dfData[[5]],
                          dfData[[6]],dfData[[7]],dfData[[8]],dfData[[9]])
  # create column name vector for dfData. Leave out the Date and Time labels
  col4DfNewData <-c("DateTime",colnames(dfData)[3:9])
  # rename the column names of dfNewData
  colnames(dfNewData) <- col4DfNewData
  #----------------------------------------------------------------------------
  # Next, plot the data. Override: main,xlab and col
  #---------------------------------------------------------------------------- 
  png(file="plot3.png",width=480,height=480)
  plot.new()
  plot(dfNewData$DateTime,dfNewData$Sub_metering_1,type='l',
       col="Black",
       xlab=" ",
       ylab="Energy sub metering")
  lines(dfNewData$DateTime,dfNewData$Sub_metering_2,
       col="Red")
  lines(dfNewData$DateTime,dfNewData$Sub_metering_3,
        col="Blue")
  legend("topright",col=c("black","red","blue"),lty=c(1,1,1),
         legend=c(col4DfNewData[6],col4DfNewData[7],col4DfNewData[8]))
  dev.off()
  
}