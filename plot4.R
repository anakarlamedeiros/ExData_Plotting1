############################################
############################################
## This R script creates plot 4 of the 
## 1st project for the course
## "Exploratory Data Analysis"
############################################
############################################


############################################
## Loading the relevant libraries 
## and setting the working directory
############################################
library(dplyr)
setwd("~/git_repositories/ExData_Plotting1")

############################################
## Reading the input file
############################################
fileToDownload = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
outputFile = "./househould_power_consuption.zip"
download.file(fileToDownload, outputFile)
data <- read.csv(unz(outputFile, "household_power_consumption.txt"), sep=";")

############################################
## Selecting the relevant data for plot 4
############################################

## Converting the column "Date" to the date format
plot4Data <- mutate(data, 
                    Date = as.Date(Date, format="%d/%m/%Y"))

## Selecting the measurements for the 1st and the 2nd of February 2007
plot4Data <- filter(plot4Data,
                    Date >= "2007-02-01" & Date <= "2007-02-02" )


############################################
## Plotting the data to the PNG device/file
############################################

## Preparing the data to plot

## Y-Axis
plot4Data <- mutate(plot4Data,
                    Global_active_power = as.numeric(as.character(Global_active_power)),
                    Voltage = as.numeric(as.character(Voltage)),
                    Sub_metering_1 = as.numeric(as.character(Sub_metering_1)),
                    Sub_metering_2 = as.numeric(as.character(Sub_metering_2)),
                    Sub_metering_3 = as.numeric(as.character(Sub_metering_3)),
                    Global_reactive_power = as.numeric(as.character(Global_reactive_power))
                    )
## X-Axis
plot4Data$Timestamp <- strptime(paste(plot4Data$Date, plot4Data$Time, sep=" "), 
                                format="%Y-%m-%d %H:%M:%S")


## Writing to the PNG device/file plot4.png with width = height = 480
png("./plot4.png", width = 480, height = 480)

## Creating 4 slots to plot the graphs (columns first)
par(mfcol=c(2,2))

## Plotting graph in cell (1,1)
plot(plot4Data[,c("Timestamp", "Global_active_power")], 
     type="l",
     xlab = "",
     ylab = "Global Active Power")

## Plotting graph in cell (2,1)
plot(plot4Data[,c("Timestamp","Sub_metering_1")], 
     type="l", 
     col="black",
     xlab = "",
     ylab = "Energy sub metering")

lines(plot4Data[,c("Timestamp","Sub_metering_2")],
      col= "red")

lines(plot4Data[,c("Timestamp","Sub_metering_3")],
      col= "blue")

legend("topright", 
       lty=c(1,1,1), 
       col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       box.lwd=0,
       inset=0.007)


## Plotting graph in cell (1,2)
plot(plot4Data[,c("Timestamp", "Voltage")], 
     type="l",
     xlab = "datetime",
     ylab = "Voltage")

## Plotting graph in cell (2,2)
plot(plot4Data[,c("Timestamp", "Global_reactive_power")], 
     type="l",
     xlab = "datetime")

## Closing the PNG device/file
dev.off()
