# ---
# Name: Christine Nguyen
# Class: Stats 133 Summer 2015
# Title: skeleton.R
# ---

# ---
# This file documents how the project directories and
# the README.md file are created. It also contains the commands 
# which download the raw data into the appropriate directories. 
# Refer to the README.md file for further information about the 
# project structure. 
# ---

# Create Project manually
# Create skeleton.R file


# --- Create subdirectories --- 
dir.create("./code")
dir.create("./rawdata")
dir.create("./data")
dir.create("./resources")
dir.create("./report")
dir.create("./images")

# --- Create README.md file --- 
file.create("./README.md")

# --- Raw Data Acquisition and Placement --- 

# Data Source for North Atlantic Basin HURDAT: 
# "ftp://eclipse.ncdc.noaa.gov/pub/ibtracs/v03r06/wmo/hurdat_format/basin/Basin.NA.ibtracs_hurdat.v03r06.hdat"

link_NAhurdat <- "ftp://eclipse.ncdc.noaa.gov/pub/ibtracs/v03r06/wmo/hurdat_format/basin/Basin.NA.ibtracs_hurdat.v03r06.hdat"

download.file(url = link_NAhurdat, 
              destfile = "./rawdata/source_NAhurdat")

# create file for data cleaning of North Atlantic basin hurdat data
file.create("./code/datacleaning_NAhurdat.R")


# Data Source for North Atlantic Basin CSV: 
# "ftp://eclipse.ncdc.noaa.gov/pub/ibtracs/v03r06/wmo/csv/basin/Basin.NA.ibtracs_wmo.v03r06.csv"

link_NAcsv <- "ftp://eclipse.ncdc.noaa.gov/pub/ibtracs/v03r06/wmo/csv/basin/Basin.NA.ibtracs_wmo.v03r06.csv"

download.file(url = link_NAcsv, 
              destfile = "./rawdata/source_NAcsv.csv")

# Data Source for East Pacific Basin CSV:
# "ftp://eclipse.ncdc.noaa.gov/pub/ibtracs/v03r06/wmo/csv/basin/Basin.EP.ibtracs_wmo.v03r06.csv"

link_EPcsv <- "ftp://eclipse.ncdc.noaa.gov/pub/ibtracs/v03r06/wmo/csv/basin/Basin.EP.ibtracs_wmo.v03r06.csv"

download.file(url = link_EPcsv, 
              destfile = "./rawdata/source_EPcsv.csv")

# Create coding file to clean EP and NA csv's: 

file.create("./code/cleaningandvisuals_EPNAcsv.R")

# Create file for report
file.create("./report/report.Rmd")

