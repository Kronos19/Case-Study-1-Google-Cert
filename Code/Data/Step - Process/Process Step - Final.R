#install.packages("tidyverse")
#install.packages("ggplot2")

library(tidyverse)
library(dplyr)
library(readr)
library(ggplot2)

#setwd([your file path])

yearly_data <- readRDS("yearly_data.Rdata")

#inspected data with below 7 functions.
 colnames(yearly_data)
 nrow(yearly_data)
 dim(yearly_data)
 head(yearly_data)
 str(yearly_data)
 summary(yearly_data)

 table(yearly_data$member_casual)

#Reassign subtypes for member_casual columns
yearly_data <- yearly_data %>%
  mutate(member_casual = recode(member_casual, "Subscriber" = "member", 
                      "Customer" = "casual"))

#breaking date-time stamps into new column
yearly_data$date <- as.Date(yearly_data$started_at)
yearly_data$month <- format(as.Date(yearly_data$date), "%m")
yearly_data$day <- format(as.Date(yearly_data$date), "%d")
yearly_data$year <- format(as.Date(yearly_data$date), "%Y")
yearly_data$day_of_week <- format(as.Date(yearly_data$date), "%A")

# Add a "ride_length" column formatted in seconds
yearly_data$ride_length <- difftime(yearly_data$ended_at, 
                                    yearly_data$started_at)

#ride_length converted from date_time format to numeric ln41-43
is.factor(yearly_data$ride_length)
yearly_data$ride_length <- as.numeric(as.character(yearly_data$ride_length))
is.numeric(yearly_data$ride_length)

#created new data frame and drop unwanted records less then 0 or from HQ
yearly_data_v2 <- yearly_data[!(yearly_data$start_station_name == "HQ QR" | 
                                  yearly_data$ride_length<0),]

#set directory and saved new data frame to file
#setwd([your file path])

saveRDS(yearly_data_v2, file = 'yearly_data_v2.Rdata')

