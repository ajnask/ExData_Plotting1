## R code for plot 2

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

# opening a png file of name 'plot2.png'
png(filename = "plot2.png")

# plotting a line plot (type = 'l') datetime vs Global_active_power
plot(powerdata$datetime,powerdata$Global_active_power, 
     type = 'l',
     ylab = "Global Active Power (kilowatts)",
     xlab= "")

# closing the png file
dev.off()
