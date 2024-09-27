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

#Plot 2
#add datetime columns to create date and time chart
png("plot2.png", width=480, height=480)
electricfiltered$datetime <- with(electricfiltered,ymd(Date)+hms(Time))
ggplot(electricfiltered,aes(x=datetime,y=Global_active_power)) + 
  geom_line() + 
  scale_x_datetime(date_breaks = "days", date_labels = c("Sat","Thu","Fri"))+
  theme_classic()+xlab("")+
  labs(x="",y="Global Active Power (kilowatts)")
dev.off()