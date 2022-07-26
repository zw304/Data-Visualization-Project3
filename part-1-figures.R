## import dataset for part2 
library(ggplot2)
#install.packages("ggpol")
library(ggpol)
part2<-read.csv("thrombosis.csv")

##figure 1.Bar plot of how gender related to thrombosis by year?
##figure 2.Box plot of how age related to thrombosis by year?
##figure 3.Jitter Plot of Thrombosis by Pattern Observed in ANA Examination 
##figure 4.Histogram and density Plot of Proteins Distribution Observed in Laboratory examinations
##figure 5.Histogram and density Plot of Cholesterol Distribution Observed in Laboratory examinations
## figure 6. Histogram Plot of Bilirubin Distribution Observed in Laboratory examinations



## figure 1: 
# start design visualiztion:  
## 1.how gender related to thrombosis by year?  bar plot 
#Based on Sex, which degree of thrombosis have the most frequency?
ggplot(data = part2, mapping=aes(x=thrombosis,color=sex))+
  geom_bar(fill="white",alpha=0.5,position="dodge")+
  labs(title ="Bar Plot of Different Degrees of Thrombosis by Gender", x = "Level of Thrombosis", y = "Population")


## figure 2:
# start design visualiztion: 2.how age related to thrombosis frequency?

ggplot(data = part2, mapping = aes(x = thrombosis, y = age,fill = sex)) +
  geom_boxplot() +
  facet_wrap(~ thrombosis, nrow = 1)+
  labs(title = "Boxplot of Thrombosis by Age", 
       x = "Level of Thrombosis", y = "Age") + 
  coord_flip()

## figure 3: 
# start design visualiztion: different ANA Patterns & thrombosis
ggplot(data = part2, aes(x=ana_pattern,y=thrombosis, color = ana_pattern))+
  geom_jitter()+
  labs(title = "Jitter Plot of Thrombosis by Pattern Observed in ANA Examination", 
       x = "ANA Pattern", y = "Level of Thrombosis") 


## figure 4: 
##density and histogram plot for tp_mean :
library(ggplot2)
theme_set(theme_classic())
ggplot(data = part2, aes(x=tp_mean))+
  geom_histogram(aes(y=..density..),color = "pink",fill ="white")+
  facet_grid(~ thrombosis)+
  geom_density(alpha=0.5,fill="#FF6666")+
  labs(title = "Histogram Plot of Proteins Distribution Observed in Laboratory examinations", x = "Protein Range", y = "Density") 


## figure 5: 
##density and histogram plot for total cholesterol (t_cho_mean): 
library(ggplot2)
theme_set(theme_classic())
ggplot(data = part2, aes(x=t_cho_mean))+
  geom_histogram(aes(y=..density..),color = "blue",fill ="white")+
  facet_grid(~ thrombosis)+
  geom_density(alpha=0.5,fill="blue") +
  labs(title = "Histogram Plot of Cholesterol Distribution Observed in Laboratory examinations", x = "Cholesterol Range", y = "Density") 


## figure 6: 
ggplot(data = part2, aes(x=t_bil_mean))+
  geom_histogram(aes(y=..density..),color = "Purple",fill ="White")+
  facet_grid(~ thrombosis)+ 
  geom_density(aes(fill = t_bil_mean,colour = "t_bil_mean"),alpha=0.05)+
  labs(title = "Histogram Plot of Bilirubin Distribution Observed in Laboratory examinations", x = "Bilirubin Range", y = "Density") 

##

