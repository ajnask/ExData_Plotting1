## R code for plot 4

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

# opening a png file of name 'plot4.png'
png(filename = "plot4.png")

# splitting the graphics device into 2 rows and 2 columns
par(mfrow=c(2,2))

# since we used mfrow command, plotting will happen row wise
# Plot 1: plotting a lineplot (type = 'l') datetime vs Global_active_power
plot(powerdata$datetime,powerdata$Global_active_power, 
     type = 'l',
     ylab = "Global Active Power",
     xlab= "")

# Plot 2: plotting a line plot datetime vs Voltage
with(powerdata,plot(datetime,Voltage,type = 'l'))

# Plot 3: plotting a line plot of all the sub metering values in a single plot
plot(powerdata$datetime,powerdata$Sub_metering_1,type = 'l',xlab = "",ylab = "Energy sub metering")
lines(powerdata$datetime,powerdata$Sub_metering_2,col = "red")
lines(powerdata$datetime,powerdata$Sub_metering_3, col = "blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = "solid",
       col = c("black","red","blue"),bty = 'n')

# Plot 4: plotting a line plot datetime vs Global_reactive_power
with(powerdata,plot(datetime,Global_reactive_power,type = 'l'))

# closing the png file
dev.off()
