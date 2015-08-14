# --- 
# Name: Christine Nguyen
# Class: Stats 133 Summer 2015
# Title: datacleaning_NAhurdat 
# --- 

# Packages Used (install as needed)
install.packages("stringr")
library(stringr)

# Import raw hurdat data 
rawhurdat <- read.csv(file = "./rawdata/source_NAhurdat", header = FALSE)

# --- Creating storms.csv --- 

# create data frame with only relevant header data of each storm
header <- as.data.frame(rawhurdat[grep("XING", rawhurdat[,1]), ])

# create id column with storm number
id <- 1:length(header[ , 1])

# create date column with class date 
date <- str_extract(header[ , 1], "[0-9]{2}/[0-9]{2}/[0-9]{4}")
# the following line of code shows how to change the class. Format 
# is kept in %m/%d/$y for the purpose of the csv
date <- as.Date(date, "%m/%d/%Y")
date <- format(date, "%m/%d/%Y")

# create days column for numer of days of storm recorded 
days <- str_extract(header[ , 1], "M=.[0-9]+")
days <- as.numeric(str_extract(days, "[0-9]+"))

# create name column with name of storm 
name <- str_extract(header[ , 1], "SNBR.*XING")
name <- substr(name, 10, nchar(name) - 4)
name <- str_trim(name, side = "both")

# put together data frame of storms.csv
dfstorms <- data.frame(id, date, days, name)

# export data frame as csv file into data folder 
write.table(dfstorms, file = "./data/storms.csv", sep = ",")

# --- Creating tracks.csv --- 
# create data frame with only relevant daily info 
daily <- as.data.frame(rawhurdat[-grep("XING", rawhurdat[,1]), ])
daily <- as.data.frame(daily[-grep("SRC", daily[,1]), ])

# create id column with storm number
daily_id <- rep(id, times = days)
daily_id <- rep(daily_id, each = 4)

# create date column with date of observation
d_date <- str_extract(daily[,1], "[0-9]{2}/[0-9]{2}")
d_date <- d_date[!is.na(d_date)]
daily_date <- rep(d_date, each = 4)
# year will be added after data.frame for tracks is created 

# create period column with period of observation during day
daily_period <- rep(c("00h", "06h", "12h", "18h"), 
                    times = length(d_date) )

# create stage column with type of stage
test <- str_extract(daily[,1], "[*SEWL].*")


# create lat column with latitude


# create long column with longitude (negative degrees for west)


# create wind column with wind speed


# create press column with storm surface pressure

