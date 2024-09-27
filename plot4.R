library(lubridate)
library(ggplot2)
library(ggpubr)
#Import Raw Data from working directory and save result as ElectricRawData variables
ElectricRawData <- read.table("household_power_consumption.txt",header = TRUE,sep = ";",na.strings = "?")

#Change the Class for all variables 
#1st Column Date as Date Class
#2nd Column Time as TIme Class
#3rd to 9th Column as numeric Class
ElectricRawData$Date <- as.Date(ElectricRawData$Date,format = "%d/%m/%Y")
ElectricRawData[,3:9] <- lapply(ElectricRawData[,3:9],as.numeric)
#filter the required date and store to variable electricfiltered

electricfiltered <- subset(ElectricRawData,Date >= "2007-02-01" & Date <= "2007-02-02")

#Plot 4
png("plot4.png", width=480, height=480)
# Make 1st Plot and store to plot1 variable
plot1 <- ggplot(electricfiltered,aes(x=datetime,y=Global_active_power)) + 
	geom_line() + 
	scale_x_datetime(date_breaks = "days", date_labels = c("Sat","Thu","Fri"))+
	theme_classic()+xlab("")+
	labs(x="",y="Global Active Power (kilowatts)")
# Make 2nd Plot and store to plot2 variable
plot2 <- ggplot(electricfiltered,aes(x=datetime,y=Voltage)) + 
	geom_line() + 
	scale_x_datetime(date_breaks = "days",date_labels = c("Sat","Thu","Fri"))+
	theme_classic()+xlab("")+
	labs(x="datetime",y="Voltage")

# Make 3rd Plot and store to plot3 variable
plot3 <- ggplot(electricfiltered) + 
	geom_line(aes(x=datetime,y=Sub_metering_1,color = "Sub_Metering_1"))+
	geom_line(aes(x=datetime,y=Sub_metering_2,color="Sub_Metering_2"))+
	geom_line(aes(x=datetime,y=Sub_metering_3,color = "Sub_Metering_3"))+
	scale_x_datetime(date_breaks = "days", date_labels = c("Sat","Thu","Fri"))+
	theme_classic()+xlab("")+labs(x="",y="Energy Sub Metering") + 
	scale_color_manual(name = "", values = c("Sub_Metering_1" = "black","Sub_Metering_2" = "red","Sub_Metering_3" = "blue"))+
	theme(legend.position = c(0.78,0.81),legend.box.background = element_rect(colour = "black",size = 1),panel.border = element_rect(color = "black",fill = NA))

# Make 4th Plot and store to plot4 variable
plot4 <- ggplot(electricfiltered,aes(x=datetime,y=Global_reactive_power)) + 
	geom_line() + 
	scale_x_datetime(date_breaks = "days",date_labels = c("Sat","Thu","Fri"))+
	theme_classic()+xlab("")+
	labs(x="datetime",y="Global_reactive_power")

#combine all plot in 1 device
ggarrange(plot1,plot2,plot3,plot4,ncol = 2,nrow=2)
dev.off()