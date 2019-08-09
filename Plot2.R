### ------------------ Plot 2 ------------------- ###
# By UcepH

# load library
library(data.table)

# column names definition to select only what we need from file
col_names <- c("Date","Time","Global_active_power")#,"Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3") 

# reading portion of file up to max_rows
max_rows <-  (16+31+3)*24*60 # max_rows is nearly the number of minutes from 16/12/2006 to 03/02/2007
raw_data <- fread("household_power_consumption.txt", 
                  sep =";", dec =".", select=col_names, nrows = max_rows)

# creating a new column with DateTime variable
raw_data[,DateTime:=(strptime(paste(Date,Time,sep = " "),format="%d/%m/%Y %H:%M:%S"))]

# define time window for analysis
start_date <- strptime("2007-02-01", format = "%Y-%m-%d") 
end_date <- strptime("2007-02-03", format = "%Y-%m-%d")

# subsetting 
proc_data <- raw_data[raw_data$DateTime < end_date & raw_data$DateTime >= start_date,] 

# converting to numeric type
proc_data[,Global_reactive_power:=as.numeric(Global_reactive_power)]


png(filename = "Plot2.png",width = 480, height = 480, units = "px")
## Create plot on device
with(proc_data, plot(DateTime,Global_active_power,
                     col = "black",
                     type = "l", # a line plot
                     ylab = "Global Active Power (kilowatts)")) 

#dev.copy(png, file = "Plot1.png")  ## Copy my plot to a PNG file
dev.off()  ## Don't forget to close the PNG device!
