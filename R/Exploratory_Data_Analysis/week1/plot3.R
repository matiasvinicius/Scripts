library(dplyr)
library(lubridate)
library(tidyr)
library(stringr)

time_begin <- Sys.time()
#Getting the data
if (!file.exists('assets/data.txt')) {
  if(!dir.exists('assets')) {
    message('Creating directory assets')
    dir.create('assets')
  }
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url, destfile = "assets/data.zip")
  unzip('assets/data.zip', 'household_power_consumption.txt')
  file.remove('assets/data.zip')
  file.rename(from='household_power_consumption.txt',to='assets/data.txt')
  message('Data downloaded in directory assets')
}

#Reading and cleannig the data
message('Reading the data from directory assets')
data <- read.delim(file='assets/data.txt', sep=';')
data <- as_tibble(data)

message('Cleanning the data')
data <- data %>%
  filter(str_detect(Date, '^2/2/2007|^1/2/2007')) %>%
  mutate(DateTime = as_datetime(mapply(paste, Date, Time),'%d/%m/%Y %H:%M:%S', tz=Sys.timezone())) %>%
  select(-c(Date, Time)) %>%
  mutate(Global_active_power = sapply(Global_active_power, as.numeric),
         Global_reactive_power = sapply(Global_reactive_power, as.numeric),
         Voltage = sapply(Voltage, as.numeric),
         Global_intensity = sapply(Global_intensity, as.numeric),
         Sub_metering_1 = sapply(Sub_metering_1, as.integer),
         Sub_metering_2 = sapply(Sub_metering_2, as.integer),
         Sub_metering_3 = sapply(Sub_metering_3, as.integer))

#Creating Plot3
png('plot3.png', width = 480, height = 480)
plot(data$Sub_metering_1~data$DateTime,
     type='l',
     ylab = 'Energy sub metering',
     xlab= '')
lines(data$Sub_metering_2~data$DateTime, col='red')
lines(data$Sub_metering_3~data$DateTime, col='blue')
legend('topright', legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col=c('black', 'red', 'blue'), lty=1)
dev.off()
message('plot3.png saved in the current directory')

time_spent <- Sys.time() - time_begin
message('Time spent: ', round(time_spent) , ' seconds')