# install.packages("tidyverse")
# install.packages("ggplot2")

library(tidyverse)
library(dplyr)
library(readr)
library(ggplot2)


#setwd([your file path])
 
    csv_2020_09 <- read_csv('202009-divvy-tripdata.csv', guess_max = 10000)
    csv_2020_10 <- read_csv('202010-divvy-tripdata.csv', guess_max = 10000)
    csv_2020_11 <- read_csv('202011-divvy-tripdata.csv', guess_max = 10000)
    csv_2020_12 <- read_csv('202012-divvy-tripdata.csv', guess_max = 10000)
    csv_2021_01 <- read_csv('202101-divvy-tripdata.csv', guess_max = 10000)
    csv_2021_02 <- read_csv('202102-divvy-tripdata.csv', guess_max = 10000)
    csv_2021_03 <- read_csv('202103-divvy-tripdata.csv', guess_max = 10000)
    csv_2021_04 <- read_csv('202104-divvy-tripdata.csv', guess_max = 10000)
    csv_2021_05 <- read_csv('202105-divvy-tripdata.csv', guess_max = 10000)
    csv_2021_06 <- read_csv('202106-divvy-tripdata.csv', guess_max = 10000)
    csv_2021_07 <- read_csv('202107-divvy-tripdata.csv', guess_max = 10000)
    csv_2021_08 <- read_csv('202108-divvy-tripdata.csv', guess_max = 10000)

yearly_data <- rbind(csv_2020_09, csv_2020_10, csv_2020_11, csv_2020_12, 
    csv_2021_01, csv_2021_02, csv_2021_03, csv_2021_04, csv_2021_05, 
    csv_2021_06, csv_2021_07, csv_2021_08)

#CSV and rbind is better than merge in divvy and with help of tidyverse

#setwd([your file path])

saveRDS(yearly_data, file = 'yearly_data.Rdata')

