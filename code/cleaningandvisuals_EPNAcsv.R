# --- 
# Name: Christine Nguyen
# Class: Stats 133 Summer 2015
# Title: datacleaning_EPNAcsv
# --- 

# -------------------------------------------------------------------
# --- Packages Used --- 
install.packages("ggplot2")
library(ggplot2)

install.packages("maps")
library(maps)

# -------------------------------------------------------------------
# --- data cleaning --- 
# import EP csv 
dfEP <- read.csv(file = "./rawdata/source_EPcsv.csv", 
                 sep = ",", header = TRUE, skip = 1, 
                 stringsAsFactors = FALSE)

# import NA csv
dfNA <- read.csv(file = "./rawdata/source_NAcsv.csv", 
                 sep = ",", header = TRUE, skip = 1, 
                 stringsAsFactors = FALSE)

# Get rid of first rows (which only provide further info about how
# columns are structured)
dfEP <- dfEP[-1,]
dfNA <- dfNA[-1,]

# Subset the above data.frames to only include data from 1980 - 2010
dfEP <- subset(dfEP, dfEP$Season >= 1980 & dfEP$Season <= 2010)
dfNA <- subset(dfNA, dfNA$Season >= 1980 & dfNA$Season <= 2010)

# Combine the subsetted data.frames into one data.frame for visualization
dfEPNA <- rbind(dfEP, dfNA)

# Keep only relevant columns 
names(dfEPNA)
df <- data.frame(dfEPNA$Serial_Num, dfEPNA$Season, dfEPNA$ISO_time,
                 dfEPNA$Latitude, dfEPNA$Longitude, dfEPNA$Wind.WMO., 
                 stringsAsFactors = FALSE)
colnames(df) <- c("SerialNum", "Season", "ISO_time", 
                  "Latitude", "Longitude", "Wind.WMO")

# Re-class season, latitude, longitude, wind.wmo, and serialnum
df$Season <- as.numeric(df$Season)
df$Latitude <- as.numeric(df$Latitude)
df$Longitude <- as.numeric(df$Longitude)
df$Wind.WMO <- as.numeric(df$Wind.WMO)
df$SerialNum <- as.factor(df$SerialNum)

# Extract just month from ISO_time
df$Month <- as.numeric(substr(df$ISO_time, 6, 7))
df$Month<- factor(df$Month, labels = month.name)

# Subset dataframe per decade for later visualizations
df80 <- subset(df, Season %in% 1980:1989)
df90 <- subset(df, Season %in% 1990:1999)
df00 <- subset(df, Season %in% 2000:2009)

# -------------------------------------------------------------------
# --- Visualization --- 

# trajectory of all storms in 1980 - 2010 
map_all <- ggplot(data = df, aes(
  x = Longitude, y = Latitude, group = SerialNum)) + 
  geom_polygon(data = map_data("world"), 
               aes(x = long, y = lat, group = group), 
               bg = "gray40", colour = "gray0", fill = TRUE) + 
  geom_path(aes(x = Longitude, y = Latitude, 
              group = SerialNum, colour = Wind.WMO)) + 
  xlim(-125, -25) + ylim(0, 55) + 
  labs(x = "", y = "", colour = "Wind (knots)") + 
  ggtitle("Hurricane Trajectories 1980-2010") + 
  theme(panel.border = element_blank(), 
        line = element_blank(), 
        axis.text = element_blank(),
        panel.background = element_rect(fill = "gray0"))

map_all

# trajectory of storms per month [one facet per month]
map_month <- ggplot(data = df, aes(
  x = Longitude, y = Latitude, group = SerialNum)) + 
  geom_polygon(data = map_data("world"), 
               aes(x = long, y = lat, group = group), 
               bg = "gray40", colour = "gray0", fill = TRUE) + 
  geom_path(aes(x = Longitude, y = Latitude, 
                group = SerialNum, colour = Wind.WMO)) + 
  facet_wrap(~Month)+
  xlim(-125, -25) + ylim(0, 55) + 
  labs(x = "", y = "", colour = "Wind (knots)") + 
  ggtitle("Hurricane Trajectories by Month 1980-2010") + 
  theme(panel.border = element_blank(), 
        line = element_blank(), 
        axis.text = element_blank(),
        panel.background = element_rect(fill = "gray0"))
map_month

# trajectory of storms in decade 1980s [one facet per year]
map80 <- ggplot(data = df80, aes(
  x = Longitude, y = Latitude, group = SerialNum)) + 
  geom_polygon(data = map_data("world"), 
               aes(x = long, y = lat, group = group), 
               bg = "gray40", colour = "gray0", fill = TRUE) + 
  geom_path(aes(x = Longitude, y = Latitude, 
                group = SerialNum, colour = Wind.WMO)) + 
  facet_wrap(~Season) + 
  xlim(-125, -25) + ylim(0, 55) + 
  labs(x = "", y = "", colour = "Wind (knots)") + 
  ggtitle("Hurricane Trajectories per Year (1980-1989)") + 
  theme(panel.border = element_blank(), 
        line = element_blank(), 
        axis.text = element_blank(),
        panel.background = element_rect(fill = "gray0"))
  
  map80

# trajectory of storms in decade 1990s [one facet per year]
map90 <- ggplot(data = df90, aes(
  x = Longitude, y = Latitude, group = SerialNum)) + 
    geom_polygon(data = map_data("world"), 
                 aes(x = long, y = lat, group = group), 
                 bg = "gray40", colour = "gray0", fill = TRUE) + 
    geom_path(aes(x = Longitude, y = Latitude, 
                  group = SerialNum, colour = Wind.WMO)) + 
    facet_wrap(~Season) + 
    xlim(-125, -25) + ylim(0, 55) + 
    labs(x = "", y = "", colour = "Wind (knots)") + 
    ggtitle("Hurricane Trajectories per Year (1990-1999)") + 
    theme(panel.border = element_blank(), 
          line = element_blank(), 
          axis.text = element_blank(),
          panel.background = element_rect(fill = "gray0"))
  
  map90

# trajectory of storms in decade 2000s [one facet per year]
map00 <- ggplot(data = df00, aes(
  x = Longitude, y = Latitude, group = SerialNum)) + 
    geom_polygon(data = map_data("world"), 
                 aes(x = long, y = lat, group = group), 
                 bg = "gray40", colour = "gray0", fill = TRUE) + 
    geom_path(aes(x = Longitude, y = Latitude, 
                  group = SerialNum, colour = Wind.WMO)) + 
    facet_wrap(~Season) + 
    xlim(-125, -25) + ylim(0, 55) + 
    labs(x = "", y = "", colour = "Wind (knots)") + 
    ggtitle("Hurricane Trajectories per Year (2000-2009)") + 
    theme(panel.border = element_blank(), 
          line = element_blank(), 
          axis.text = element_blank(),
          panel.background = element_rect(fill = "gray0"))
  
map00

# --- Save produced graphs as png files in images folder ---
# map_all
png(filename = "./images/map_all.png") 
plot(map_all)
dev.off()

pdf("./images/map_all.pdf")
plot(map_all)
dev.off()

# map_month
png(filename = "./images/map_month.png")
plot(map_month)
dev.off()

pdf("./images/map_month.pdf")
plot(map_month)
dev.off()

# map80
png(filename = "./images/map80.png")
plot(map80)
dev.off()

pdf("./images/map80.pdf")
plot(map80)
dev.off()

# map90 
png(filename = "./images/map90.png")
plot(map90)
dev.off()

pdf("./images/map90.pdf")
plot(map90)
dev.off()

# map00 
png(filename = "./images/map00.png")
plot(map00)
dev.off()

pdf("./images/map00.pdf")
plot(map00)
dev.off()
