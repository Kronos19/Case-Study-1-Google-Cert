#install.packages("tidyverse")
#install.packages("ggplot2")
#install.packages("kableExtra")

library(tidyverse)
library(dplyr)
library(readr)
library(ggplot2)
library(lubridate)
library(kableExtra)

#setwd([your file path])

#Loading in data frame and dropping all records with NAs
yearly_data_v2 <- readRDS("yearly_data_v2.Rdata")

yearly_data_v2 <- yearly_data_v2 %>% drop_na() 

summary(yearly_data_v2)

table(yearly_data_v2$member_casual)
table(yearly_data_v2$rideable_type)

#Table of 5 docking stations most and least frequented
#sorted descending, and formatted as a data frame

start_station_feq_table <- sort(table(yearly_data_v2$start_station_name),
                          decreasing = TRUE)

end_station_feq_table <- sort(table(yearly_data_v2$end_station_name),
                                decreasing = TRUE)

top_five_start_station <- as.data.frame(head(start_station_feq_table, n=5))

bottom_five_start_station <- as.data.frame(tail(start_station_feq_table, n=5))

top_five_end_station <- as.data.frame(head(end_station_feq_table, n=5))

bottom_five_end_station <- as.data.frame(tail(end_station_feq_table, n=5))

#binding start and end station data into two data frames
#rename columns and create tables of station ride count
#then creates a table for them
#also converts data frames to a vector for following code
s_stations <- bind_rows(top_five_start_station, 
                       bottom_five_start_station,)
e_stations <- bind_rows(top_five_end_station,
                               bottom_five_end_station)

s_stations_mod <- rename(s_stations, station_name = Var1, 
       ride_count = Freq)
e_stations_mod <- rename(e_stations, station_name = Var1, 
       ride_count = Freq)

s_stations <- as.vector(s_stations_mod$station_name)

e_stations <- as.vector(e_stations_mod$station_name)

#start station ride count 
yearly_data_v2 %>%
  filter(start_station_name %in% s_stations) %>%
  group_by(member_casual, rideable_type) %>% 
  ggplot(aes(x = member_casual,
             fill = start_station_name)) +
  geom_bar(position = "dodge") + labs(title = "Start Station Ride Count") +
  theme(legend.position = "bottom", 
        legend.key.size = unit(.5, 'cm'),
        legend.text = element_text(margin = margin(r = 5, unit = "pt")),
        legend.margin = margin(c(0, 0, 0, 0)),
        legend.title = element_blank(),
        legend.justification = c(0, 0),
        legend.key.height = unit(.1, 'cm')) + 
  guides(fill=guide_legend(nrow=5, byrow=TRUE)) +
  scale_fill_manual(values = 
        c("Streeter Dr & Grand Ave" = "#88CCEE", 
          "Michigan Ave & Oak St" = "#CC6677", 
          "Clark St & Elm St" = "#DDCC77", "Theater on the Lake" = "#117733", 
          "Millennium Park" = "#332288", "Harlem Ave & Grace St" = "#AA4499", 
          "Lyft Driver Center Private Rack" = "#44AA99", 
          "N Hampden Ct & W Diversey Ave" = "#999933", 
          "North Ave & New England Ave" = "#661100", 
          "Pulaski Rd & 21st St" = "#888888")) +
  facet_wrap(~rideable_type)

#end station ride count
yearly_data_v2 %>%
  filter(., end_station_name %in% e_stations) %>%
  group_by(member_casual, rideable_type) %>% 
  ggplot(., (aes(x = member_casual,
    fill = end_station_name))) +
    geom_bar(position = "dodge") + labs(title = "End Station Ride Count") +
  theme(legend.position = "bottom", 
        legend.key.size = unit(.5, 'cm'),
        legend.text = element_text(margin = margin(r = 5, unit = "pt")),
        legend.margin = margin(c(0, 0, 0, 0)),
        legend.title = element_blank(),
        legend.justification = c(0, 0),
        legend.key.height = unit(.1, 'cm')) + 
  guides(fill=guide_legend(nrow=5, byrow=TRUE)) +
  scale_fill_manual(values = 
        c("Streeter Dr & Grand Ave" = "#88CCEE", 
          "Michigan Ave & Oak St" = "#CC6677", 
          "Millennium Park" = "#DDCC77", "Theater on the Lake" = "#117733", 
          "Clark St & Elm St" = "#332288", "Kilbourn & Belden" = "#AA4499", 
          "Kildare Ave & 26th St" = "#44AA99", 
          "N Hampden Ct & W Diversey Ave" = "#999933", 
          "North Ave & New England Ave" = "#661100", 
          "Parkside Ave & Armitage Ave" = "#888888")) +
    facet_wrap(~rideable_type)

#sorting data frame by days of week
yearly_data_v2$day_of_week <- ordered(yearly_data_v2$day_of_week, 
                                    levels=c("Sunday", "Monday", "Tuesday", 
                                             "Wednesday", "Thursday", 
                                             "Friday", "Saturday"))

# Let's create a visualization for average duration by day of week
yearly_data_v2 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday, rideable_type) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)/60) %>% 
  arrange(member_casual, weekday)  %>% 
  ggplot(aes(x = weekday, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge") + 
  scale_fill_manual(values = c("casual" = "#F5793A", "member" = "#85C0F9")) + 
  labs(title = "Average Ride Duration by Day of Week") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  facet_wrap(~rideable_type)

# Let's create a visualization for average duration, monthly
yearly_data_v2 %>% 
  mutate(monthly = month(started_at, label = TRUE)) %>% 
  group_by(member_casual, monthly, rideable_type) %>% 
  summarise(number_of_rides = n()
            ,average_duration = mean(ride_length)/60) %>% 
  ggplot(aes(x = monthly, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge") + 
  scale_fill_manual(values = c("casual" = "#F5793A", "member" = "#85C0F9")) + 
  labs(title = "Average Ride Duration by Month") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  facet_wrap(~rideable_type)

# Visualize the ridership count by membership type and day of week
# Rides in thousands
yearly_data_v2 %>% 
  mutate(weekday = wday(started_at, label = TRUE)) %>% 
  group_by(member_casual, weekday) %>% 
  summarise(number_of_rides = n()) %>%
  mutate(number_of_rides = number_of_rides/1000) %>%
  arrange(member_casual, weekday)  %>% 
  ggplot(aes(x = weekday, y = number_of_rides, fill = member_casual)) + 
  labs(y= "Number of Rides (thousands)", fill = "Subtypes") +
  geom_col(position = "dodge") + scale_fill_manual(values = 
    c("casual" = "#F5793A", "member" = "#85C0F9")) + 
    labs(title = "Ride Count by Day of Week")

# Visualize the ridership count by membership type and month
# Rides in thousands
df <- yearly_data_v2 %>% 
  mutate(monthly = EOMONTH(DATE(year,month,day), months = 0)) %>% 
  group_by(member_casual, monthly, rideable_type) %>% 
  summarise(number_of_rides = n()) %>% 
mutate(number_of_rides = round(number_of_rides/1000)) %>% 
  drop_na() 

df %>%   
  ggplot(aes(x = monthly, y = number_of_rides, fill = member_casual)) + 
  labs(y= "Number of Rides (thousands)", fill = "Subtypes",
       title = "Ride Count by Month") +
  geom_bar(position = "dodge", stat="identity") + 
  scale_fill_manual(values = c("casual" = "#F5793A", "member" = "#85C0F9")) + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  facet_wrap(~rideable_type)

#Create a summary file with averages of data for export as a CSV file.
counts <- aggregate(yearly_data_v2$ride_length ~ yearly_data_v2$member_casual + 
                      yearly_data_v2$day_of_week, FUN = mean)


# write.csv(counts, file = [your file path])

