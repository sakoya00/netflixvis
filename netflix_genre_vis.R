#library (dplyr)
#library (tidyr)
#library (ggplot2)
#setwd("D:/netflix/netflix_data_set")
#theme_update(plot.title = element_text(hjust = 0.5))

netflix <- read.csv("netflix_titles.csv", header=T, na.strings=c("","NA"))
netflix2 <- cbind(netflix$country, netflix$listed_in, factor.exclude= NA)
netflix2 <-na.omit(netflix2)
netflix3 <-as_tibble(netflix2)
write.csv(netflix3, "netflix3.csv")

#I did some cleaning in Excel then moved back to the below code
netflix4 <- read.csv("netflix3.csv", header=T)
netflix5 <- separate_rows(netflix4, Country, sep=", ")
netflix6 <- separate_rows(netflix5, Genre, sep=", ")
write.csv(netflix6, "netflix6.csv")

#Top 10 countries which use Netflix the most, according to
#https://www.businessinsider.com/netflix-countries-most-popular-user-penetration-2018-7#1-united-states-645-user-penetration-10
countrysub <- c("United Kingdom", "Germany", "Finland", "Australia", "Netherlands", "Sweden", "Denmark", "Canada", "Norway", "United States")
n7 <- filter(netflix6, is.element(Country, countrysub))

plot <- n7 %>%
    count(Country, Genre) %>%
    ggplot(aes(x=Country, y=Genre))+
    geom_tile(aes(fill=n))+
    scale_fill_distiller(palette="RdPu")+
    ggtitle("Countries' Top Netflix Genres")

plot
