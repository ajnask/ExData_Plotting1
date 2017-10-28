## R code for plot 3

## Collecting the column names as it will be missed while using skip function
colNames <- names(read.table("household_power_consumption.txt",nrows = 1,sep = ";",header = TRUE))

## Reading data, but only of dates 1/2/2007 and 2/2/2007
powerdata <- read.table(file = "household_power_consumption.txt",
                        sep = ';',
                        col.names = colNames,
                        # skipping to first entry with 1/2/2007
                        skip = grep("^1/2/2007",readLines("household_power_consumption.txt"))[1]-1,
                        na.strings = c("","?"),
                        # taking only the rows corresponding to 1/2/2007 and 2/2/2007
                        nrows = (grep("^3/2/2007",readLines("household_power_consumption.txt"))[1]
                                 -grep("^1/2/2007",readLines("household_power_consumption.txt"))[1])
)

library(lubridate)

# making a column named 'datetime' as a combination of Date and Time columns
powerdata$datetime <- dmy_hms(paste(powerdata$Date,powerdata$Time))

# opening a png file of name 'plot3.png'
png(filename = "plot3.png")

# plotting a line graph of datetime vs Sub_metering_1
plot(powerdata$datetime,powerdata$Sub_metering_1,type = 'l',xlab = "",ylab = "Energy sub metering")

# plotting a line graph of datetime vs Sub_metering_2 in the same plot as above
lines(powerdata$datetime,powerdata$Sub_metering_2,col = "red")

# plotting a line graph of datetime vs Sub_metering_3 in the sample plot as above
lines(powerdata$datetime,powerdata$Sub_metering_3, col = "blue")

# adding a legend to the top right corner of the plot
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = "solid",
       col = c("black","red","blue"))

# closing the png file
dev.off()
