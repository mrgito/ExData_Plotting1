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
#Plot 3
png("plot3.png", width=480, height=480)
ggplot(electricfiltered) + 
	geom_line(aes(x=datetime,y=Sub_metering_1,color = "Sub_Metering_1"))+
	geom_line(aes(x=datetime,y=Sub_metering_2,color="Sub_Metering_2"))+
	geom_line(aes(x=datetime,y=Sub_metering_3,color = "Sub_Metering_3"))+
	scale_x_datetime(date_breaks = "days", date_labels = c("Sat","Thu","Fri"))+
	theme_classic()+xlab("")+labs(x="",y="Energy Sub Metering") + 
	scale_color_manual(name = "", values = c("Sub_Metering_1" = "black","Sub_Metering_2" = "red","Sub_Metering_3" = "blue"))+
	theme(legend.position = c(0.88,0.91),legend.box.background = element_rect(colour = "black",size = 1),panel.border = element_rect(color = "black",fill = NA))
dev.off()
