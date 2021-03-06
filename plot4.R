###
# This script is to satisfy the project portion of the Data Scientist - Exploratory Data Analysis online class.
# 

plot4 <- function() {
    ###
    # This function will download and read in data (clean data too), add the column names, convert the weekday to the
    # abbreviated form, add the date_time column, generate plot #4 (4 plots in 1), and save that plot to a plot4.png file.
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


    ### Add a new "weekday" column.
    my_weekday <- weekdays(as.Date(as.character(my_data[,1]), "%d/%m/%Y"))
    my_data <- cbind(my_data, my_weekday)
    my_len <- length(names(my_data))
    names(my_data)[my_len] <- "weekday"
    my_data$weekday <- as.character(my_data$weekday)
  
    ### Convert "Thursday" to "Thus", and etc.
    my_data$weekday[my_data$weekday == "Sunday"] <- "Sun"
    my_data$weekday[my_data$weekday == "Monday"] <- "Mon"
    my_data$weekday[my_data$weekday == "Tuesday"] <- "Tues"
    my_data$weekday[my_data$weekday == "Wednesday"] <- "Wed"
    my_data$weekday[my_data$weekday == "Thursday"] <- "Thur"
    my_data$weekday[my_data$weekday == "Friday"] <- "Fri"
    my_data$weekday[my_data$weekday == "Saturday"] <- "Sat"

  
    ### Add date_time column
    my_data = cbind(my_data, as.POSIXct(paste(my_data$Date, my_data$Time), format="%d/%m/%Y %H:%M:%S"))
    my_len <- length(names(my_data))
    names(my_data)[my_len] <- "date_time"
 
    ### Generate Plot 4 and save the plot to a PNG file with a width of 480 pixels and a height of 480 pixels.
    my_orig_par <- par()
    par(mfrow=c(2,2))

    # Top left plot 
    plot(my_data$date_time, my_data$Global_active_powe, type="l", lwd=1.4, xlab="", ylab="", main="")
    title(ylab="Global Active Power")

    # Top right plot
    plot(my_data$date_time, my_data$Voltage, type="l", lwd=1, col="black", xlab="", ylab="", main="")
    title(xlab="datetime")
    title(ylab="Voltage")

    # Bottom left plot 
    plot(my_data$date_time, my_data$Sub_metering_1, type="l", lwd=1.5, col="black", xlab="", ylab="", main="")
    lines(my_data$date_time, my_data$Sub_metering_2, type="l", lwd=1.5, col="red", xlab="", ylab="", main="")
    lines(my_data$date_time, my_data$Sub_metering_3, type="l", lwd=1.5, col="blue", xlab="", ylab="", main="")
    title(ylab="Energy sub metering")
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=c(1.5, 1.5), lty=c(1,1), col=c("black", "red", "blue"))

    # Bottom right plot
    plot(my_data$date_time, my_data$Global_reactive_power, type="l", lwd=1, col="black", xlab="", ylab="", main="")
    title(xlab="datetime")
    title(ylab="Global_reactive_power")

    dev.copy(png, "plot4.png", width=480, height=480)
    dev.off()
    par(my_orig_par)


}

