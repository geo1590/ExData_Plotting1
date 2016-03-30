
###
# This script is to satisfy the project portion of the Data Scientist - Exploratory Data Analysis online class.
# 


plot1 <- function() {
    ###
    # This function will download and read in data (clean data too), add the column names,  generate plot #1,
    # and save that plot to a plot1.png file.
    #

    file1Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    file1Zip <- "./data/data1.zip"
    file1Txt <- "./data/household_power_consumption.txt"

    ### Download zip file.
    if(!file.exists("./data")){dir.create("./data")}
    download.file(file1Url, destfile=file1Zip, method="curl")

    ### Extract zip file.
    unzip(file1Zip, exdir="./data")

    ### Read data.
    my_data <- read.csv(file1Txt, header=F, skip=66637, nrows=2880, sep=";", na.strings = c("?"))	# Date format: dd/mm/yyyy in file1Txt file.
    my_colnames <- read.csv(file1Txt, header=F, nrows=1, sep=";")

    ### Assign column names
    colnames(my_data) <- unlist(my_colnames[1,])


    ### Generate Plot 1 and save the plot to a PNG file with a width of 480 pixels and a height of 480 pixels.
    hist(my_data$Global_active_power, col="red", lwd=2, xlab="", ylab="", main="", family="B", font.main=2)
    title(xlab="Global Active Power (kilowatts)")
    title(ylab="Frequency")
    title(main="Global Active Power", family="B", font.main=2)
    dev.copy(png, "plot1.png", width=480, height=480)
    dev.off()
}

