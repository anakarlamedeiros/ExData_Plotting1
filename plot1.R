############################################
############################################
## This R script creates plot 1 of the 
## 1st project for the course
## "Exploratory Data Analysis"
############################################
############################################


############################################
## Loading the relevant libraries
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
## Selecting the relevant data for plot 1
############################################

## Converting the column "Date" to the date format
plot1Data <- mutate(data, 
                    Date = as.Date(Date, format="%d/%m/%Y"))

## Selecting the measurements for the 1st and the 2nd of February 2007
plot1Data <- filter(plot1Data,
                    Date >= "2007-02-01" & Date <= "2007-02-02" )


############################################
## Plotting the data to the PNG device/file
############################################

## Preparing the data to plot
plot1Data <- mutate(plot1Data,
                    Global_active_power = as.numeric(as.character(Global_active_power)))

## Writing to the PNG device/file plot1.png with width = height = 480
png("./plot1.png",
    width = 480,
    height = 480)

## Plotting the data
hist(plot1Data$Global_active_power, 
     breaks=12,
     main = "Global Active Power",
     xlab = "Global Active Power (killowatts)",
     col="red")

## Closing the PNG device/file
dev.off()
