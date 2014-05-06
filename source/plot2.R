plot2 <- function() {
  #----------------------------------------------------------------------------
  # Read from the file records corresponding to dates '1/2/2007' and '2/2/2007'
  # and create a data frame
  #----------------------------------------------------------------------------
  require("sqldf")
  setwd("/home/syed/exploratorydataanalysis/ExData_Plotting1")
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
  png(file="plot2.png",width=480,height=480)
  plot.new()
  plot(dfNewData$DateTime,dfNewData$Global_active_power,type='l',
       xlab=" ",
       ylab="Global Active Power (kilowatts)")
  dev.off()
  
}