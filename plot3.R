############################################
############################################
## This R script creates plot 3 of the 
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
## Selecting the relevant data for plot 3
############################################

## Converting the column "Date" to the date format
plot3Data <- mutate(data, 
                    Date = as.Date(Date, format="%d/%m/%Y"))

## Selecting the measurements for the 1st and the 2nd of February 2007
plot3Data <- filter(plot3Data,
                    Date >= "2007-02-01" & Date <= "2007-02-02" )


############################################
## Plotting the data to the PNG device/file
############################################

## Preparing the data to plot

## Y-Axis
plot3Data <- mutate(plot3Data,
                    Sub_metering_1 = as.numeric(as.character(Sub_metering_1)),
                    Sub_metering_2 = as.numeric(as.character(Sub_metering_2)),
                    Sub_metering_3 = as.numeric(as.character(Sub_metering_3))
                    )
## X-Axis
plot3Data$Timestamp <- strptime(paste(plot3Data$Date, plot3Data$Time, sep=" "), 
                                format="%Y-%m-%d %H:%M:%S")


## Writing to the PNG device/file plot3.png with width = height = 480
png("./plot3.png", width = 480, height = 480)

## Plotting the data 
plot(plot3Data[,c("Timestamp","Sub_metering_1")], 
     type="l", 
     col="black",
     xlab = "",
     ylab = "Energy sub metering")

lines(plot3Data[,c("Timestamp","Sub_metering_2")],
      col= "red")

lines(plot3Data[,c("Timestamp","Sub_metering_3")],
      col= "blue")

legend("topright", 
       lty=c(1,1,1), 
       col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Closing the PNG device/file
dev.off()
