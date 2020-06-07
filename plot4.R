if(!file.exists("household_power_consumption.txt"))
{fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl,destfile="./Power_consumption.zip")
unzip("Power_consumption.zip")
}

#read first rows to check data and columns
check<-read.table("household_power_consumption.txt", header=TRUE,sep=";", nrows=3)
#Date and Time are chr

#avoid reading all 2,075,259 rows
#"We will only be using data from the dates 2007-02-01 and 2007-02-02."
#read only 70000 rows that contain relevant information
#replace "?" and define columns as numeric
hpc <-read.table("household_power_consumption.txt", header=TRUE,sep=";", nrows=70000,na.strings=c("?"),
                 colClasses=c("character", "character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))


#Transform Date and Time variables to Date/Time format
hpc$Date<-as.Date(hpc$Date, format = "%d/%m/%Y")
hpc$Time<-strptime(paste(hpc$Date,hpc$Time),"%F %T")

#subset data
hpc<-subset(hpc,hpc$Date %in% as.Date(c("2007-02-01","2007-02-02")))

#create plot4 to check before saving
par(mfcol=c(2,2))
# Plot 4.1
plot(hpc$Time,hpc$Global_active_power, ylab="Global Active Power (kilowatts)", 
     xlab="", pch =".", type="l")
# Plot 4.2
plot(hpc$Time,hpc$Sub_metering_1,ylab="Energy sub metering", xlab="", type="l", col="black")
points(hpc$Time,hpc$Sub_metering_2, col="red", type="l")
points(hpc$Time,hpc$Sub_metering_3, col="blue", type="l")
legend("topright", lwd=1, col=c("black", "red", "blue"), legend=names(hpc[,7:9]), bty="n")
# Plot 4.3
plot(hpc$Time,hpc$Voltage, ylab="Voltage", xlab="datetime", type="l")
# Plot 4.4
plot(hpc$Time,hpc$Global_reactive_power, ylab="Global_reactive_power", xlab="datetime", type="l")

#create pngfile
png("plot4.png", width=480, height=480)
par(mfcol=c(2,2))
# Plot 4.1
plot(hpc$Time,hpc$Global_active_power, ylab="Global Active Power (kilowatts)", 
     xlab="", pch =".", type="l")
# Plot 4.2
plot(hpc$Time,hpc$Sub_metering_1,ylab="Energy sub metering", xlab="", type="l", col="black")
points(hpc$Time,hpc$Sub_metering_2, col="red", type="l")
points(hpc$Time,hpc$Sub_metering_3, col="blue", type="l")
legend("topright", lwd=1, col=c("black", "red", "blue"), legend=names(hpc[,7:9]), bty="n")
# Plot 4.3
plot(hpc$Time,hpc$Voltage, ylab="Voltage", xlab="datetime", type="l")
# Plot 4.4
plot(hpc$Time,hpc$Global_reactive_power, ylab="Global_reactive_power", xlab="datetime", type="l")
dev.off()

#"Construct the plot and save it to a PNG file with a width of 480
#pixels and a height of 480 pixels."