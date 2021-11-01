# Google Data Analytics Capstone Project

# Loading required packages

install.packages("tidyverse")
library(tidyverse)
library(lubridate)
library(dplyr)

# Loading the dataset and merging them into single dataframe

files <- dir(pattern = "*.csv")
files

trip_data <- files %>%
  map(read_csv) %>%   
  reduce(rbind)        

glimpse(trip_data)

#Renaming few columns for better understanding

renamed_col <- trip_data %>% 
  rename(start_time=started_at, end_time = ended_at,user_type= member_casual
         , bike_type = rideable_type)
glimpse(renamed_col)
head(renamed_col)

# Adding new column to find trip duration

with_trip_duration <-mutate(renamed_col, trip_duration= as.duration
                            (interval(ymd_hms(renamed_col$start_time),
                                      ymd_hms(renamed_col$end_time))))

glimpse(with_trip_duration)

# Adding another column

with_week_day <- with_trip_duration %>% 
  mutate(weekday=weekdays(as.Date(with_trip_duration$start_time)))

glimpse(with_week_day)

#Checking consistency of the data in the columns

unique(with_week_day$user_type)
unique(with_week_day$bike_type)

# Removing few column which are not going to be used in my analysis

week_data <- with_week_day
week_data$start_lat = NULL
week_data$start_lng = NULL
week_data$end_lat = NULL
week_data$end_lng = NULL
colnames(week_data)

#removing null values

is.null(week_data)
cleaned_trip <-na.omit(week_data) 
cleaned_trip

# we have removed 152,302 rows of duplicate data which i am assuming to be negligible considering size of dataset
#After removing null values we have 3.3 million rows of data.

user_count <-table(cleaned_trip$user_type)
user_count
plot(user_count)
pie(user_count)

# Since the data set is very huge we are splitting it up for the ease of analysis

mem_data <- filter(cleaned_trip,user_type == 'member')
cas_data <- filter(cleaned_trip,user_type=='casual')

# Exporting out to .csv files for further analysis SQL AND POWERBI
write.csv(mem_data,file = "mem_data.csv")
write.csv(cas_data,file = "cas_data.csv")

