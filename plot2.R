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

#create plot2 to check before saving
par(mfrow=c(1,1))
plot(hpc$Time,hpc$Global_active_power, ylab="Global Active Power (kilowatts)", 
     xlab="", pch =".", type="l")

#create pngfile
png("plot2.png", width=480, height=480)
par(mfrow=c(1,1))
plot(hpc$Time,hpc$Global_active_power, ylab="Global Active Power (kilowatts)", 
     xlab="", pch =".", type="l")
dev.off()

#"Construct the plot and save it to a PNG file with a width of 480
#pixels and a height of 480 pixels."