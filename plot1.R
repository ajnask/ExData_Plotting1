## R code for plot 1

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

# opening a png file of name 'plot1.png'
png(filename = "plot1.png")

# plotting a histogram of Global_active_power
hist(powerdata$Global_active_power,
     col = 'red',
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

# closing the png file
dev.off()
