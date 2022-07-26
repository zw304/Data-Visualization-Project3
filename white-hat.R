## import library: ggplot2
library(ggplot2)

## read csv:
white_hat<- read.csv("white-hat-data.csv")
### try ggplot: bar plot and fitted line

ggplot(data = white_hat, aes(x=Year,y=Value,color = Country, group = Country))+
  geom_bar(stat="identity",position=position_dodge())+theme_minimal()+
  facet_wrap(~Country)+
  geom_smooth(method = "lm", alpha = .15,aes(fill = Country))+
  labs(title ="Greenhouse Gases Trend for Four Countries",x = "Year",y="Greenhouse Gases Value(in thousands)")
## done 
