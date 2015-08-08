############################################
############################################
## This R script creates plot 2 of the 
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
## Selecting the relevant data for plot 2
############################################

## Converting the column "Date" to the date format
plot2Data <- mutate(data, 
                    Date = as.Date(Date, format="%d/%m/%Y"))

## Selecting the measurements for the 1st and the 2nd of February 2007
plot2Data <- filter(plot2Data,
                    Date >= "2007-02-01" & Date <= "2007-02-02" )


############################################
## Plotting the data to the PNG device/file
############################################

## Preparing the data to plot

## Y-Axis
plot2Data <- mutate(plot2Data,
                    Global_active_power = as.numeric(as.character(Global_active_power)))
## X-Axis
plot2Data$Timestamp <- strptime(paste(plot2Data$Date, plot2Data$Time, sep=" "), 
                                format="%Y-%m-%d %H:%M:%S")


## Writing to the PNG device/file plot2.png with width = height = 480
png("./plot2.png", width = 480, height = 480)

## Plotting the data
plot(plot2Data$Timestamp, plot2Data$Global_active_power, 
     type="l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

## Closing the PNG device/file
dev.off()
