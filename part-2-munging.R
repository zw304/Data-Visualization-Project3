#library: 
library(dplyr)


## read csv files: 
air<- read.csv("AIR_GHG_11032022230750878.csv")
head(air)
air<-air[-c(7,13,14,16,17)] 

# for white hat hacker: discovering how '3 - Agriculture' contribute to air condition 

white<-air %>% filter(Variable == "3 - Agriculture")
head(white)
white<-white[-c(1,3,6,8)] ## delete useless rows

## keep US, Korea, France, and Australia to compare algulature influence on different countries:
white<-white %>% filter(Country == "United States"| Country == "Korea"| Country == "France"| Country == "Australia")

## only keep Tonnes of CO2 equivalent instead of Percentage
white<-white %>% filter(Unit == "Percentage")
head(white)
nrow(white) ##199 
ncol(white) ##8 

write.csv(white,"white-hat-data.csv",row.names=FALSE,na="")


## black hat hacker: dataset: 
## our goal is to:intentionally misleading readers by:
## transforming dataset with incorrect method and creating misleading labels

## To transform, filter, or process data in an intentionally misleading way: 
head(air)

## since we have a variable called Total emissions excluding LULUCF and the corresponding VAR called TOTAL
## one misleading way is just set Total as the meaning of 'Total emissions (includes LULUCF)'

## Goal: mislead readers to minifest the influence of LULUCF to benefit Land Development Corporation such as Property developer / Real estate development 
black<-air %>% filter(VAR == "TOTAL") 
head(black)

## focusing on another 4 countries: 
black_revised<-black %>% filter(Country == "United States"|Country == "China (People's Republic of)" |Country == "New Zealand"|Country == "Germany")

## if a hacker would like to emphasis the trend of "Greenhouse gases" in China he would do the following transofrming: 
black_revised$Pollutant[black_revised$Country == "China (People's Republic of)"] <- "Greenhouse gases" 

## delete useless columns: 
black_revised<-black_revised[-c(1,3,8,10)] 

write.csv(black_revised,"black-hat-data.csv",row.names=FALSE,na="")

## successfully transformed and filtered 

## Misleading title of changing 30 years to 50 years & misleading y-axis labels of changing total pollutant to average value
## try to get a sample plot in r first
#ggplot(data = black_revised, aes(x=Year,y=Value,color = Country, group = Country))+
#  geom_jitter(stat="identity")+
#  facet_wrap(~Pollutant)+
  #geom_smooth(method = "lm", alpha = .15)+
#  labs(title ="Polluntant Distribution in 50 Years",x = "Year",y="Average Pollutant values(in thousands)")
## done 





