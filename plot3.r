#y-ax = energy sub metering
#3-part legend in top right
#same date range

setwd("/home/thea/Desktop/R working directory")

file <- read.table("household_power_consumption.txt",sep=";")
file <- tail(file,-1) #to get rid of column headers that got imported as row 1

smallfile <- file[file$V1=="1/2/2007" | file$V1=="2/2/2007",] #only need these dates

#create new column with combined date and time
smallfile[,1] <- as.Date(smallfile[,1], format = "%d/%m/%Y") #converts characters to type=date
newcolumn <- paste(smallfile[,1],smallfile[,2]) #combine date and time into one columne
datetimecol <- strptime(newcolumn, format = "%Y-%m-%d %H:%M:%S") #convert into one, large date/time column
smallfile <- cbind(datetimecol,smallfile[,3:9]) #overwrites with new matrix

#convert sub_metering to matrix
smallfile[,6:8] <- as.matrix(smallfile[,6:8])

#name columns
colnames(smallfile) <- c("Date_Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

#create plot
png("plot3.png", width=480, height=480)
#par(mfrow=c(1,1))
plot(smallfile[,1], smallfile[,6], type="l", xlab="", ylab="Energy sub metering", cex=.5)
lines(smallfile[,1], y=smallfile[,7], col="red")
lines(smallfile[,1], y=smallfile[,8], col="blue")
legend(x="topright",colnames(smallfile[,6:8]),col=c("black","red","blue"), lwd=1, cex=.75)
dev.off()
