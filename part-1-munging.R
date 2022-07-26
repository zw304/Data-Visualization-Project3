library(tidyverse) ## Load the tidyverse packages, which include dplyr
##### ----------------------- TSUMOTO_A.csv -----------------------------
tsumoto_a <- read.csv("part-1-data/TSUMOTO_A.csv")
head(tsumoto_a)
ncol(tsumoto_a) #7
nrow(tsumoto_a) #1240
##using package to rename:
## nice reference: https://stackoverflow.com/questions/13258020/change-letter-case-of-column-names
#tsumoto_a<-tsumoto_a %>% 
#  dplyr::rename(
#    id = ID,
#    sex = SEX,
#    birthday = Birthday,
#    description = Description,
#    first_date = First.Date,
#    admission=Admission,
#    diagnosis = Diagnosis
#  ) 
  ## rename the column name with all lower case and _ instead of space (snake style)

##a better way to use snake pacakge:
##https://www.rdocumentation.org/packages/snakecase/versions/0.11.0/topics/to_any_case
colnames(tsumoto_a) <- snakecase::to_any_case(colnames(tsumoto_a), case = c("snake"))
head(tsumoto_a) 
str(tsumoto_a)

##check duplicated rows --> false
duplicated(tsumoto_a) | duplicated(tsumoto_a, fromLast = TRUE) 
tsumoto_a <-tsumoto_a %>% distinct(id, .keep_all = TRUE)
nrow(tsumoto_a) ## decrease to 1238 rows, 2 duplicated rows

##check na  missing values 
head(is.na(tsumoto_a)) ## --> check value shows 'na'

##drop useless columns:
tsumoto_a<-subset(tsumoto_a , select=-c(description,first_date,diagnosis))
tsumoto_a 
###----------------------- TSUMOTO_B.csv -----------------------------
tsumoto_b <- read.csv("part-1-data/TSUMOTO_B.csv")
head(tsumoto_b)
ncol(tsumoto_b) #13
nrow(tsumoto_b) #806

##a better way to use snake pacakge:
##https://www.rdocumentation.org/packages/snakecase/versions/0.11.0/topics/to_any_case
colnames(tsumoto_b) <- snakecase::to_any_case(colnames(tsumoto_b), case = c("snake"))
head(tsumoto_b) ## have wrong name using the auto package, need to rename some again by hands
tsumoto_b<-tsumoto_b %>% 
  dplyr::rename(
    acl_igg = a_cl_ig_g ,
    acl_igm = a_cl_ig_m,
    acl_iga = a_cl_ig_a,
)
str(tsumoto_b)

##check duplicated rows --> false
#duplicated(tsumoto_b) | duplicated(tsumoto_b, fromLast = TRUE) 
tsumoto_b<-tsumoto_b %>% distinct(id, .keep_all = TRUE)
nrow(tsumoto_b) ##  768 rows, 38 duplicated rows

##check na  missing values 
#head(is.na(tsumoto_b)) ## --> check value shows 'na'

## JOIN 2 tables: https://stackoverflow.com/questions/1299871/how-to-join-merge-data-frames-inner-outer-left-right
##using outer join:
tsumoto_ab<-merge(x = tsumoto_b, y =tsumoto_a , by = "id", all.x = TRUE) 
#tsumoto_ab = separate_rows(tsumoto_ab,7,sep = ",")
head(tsumoto_ab)
nrow(tsumoto_ab) #768 rows  
ncol(tsumoto_ab) ##16


###----------------------- TSUMOTO_C.csv -----------------------------
tsumoto_c <- read.csv("part-1-data/TSUMOTO_C.csv", stringsAsFactors=FALSE, fileEncoding="latin1")
nrow(tsumoto_c) ## 57545
ncol(tsumoto_c) ## 44

##a better way to use snake pacakge:
##https://www.rdocumentation.org/packages/snakecase/versions/0.11.0/topics/to_any_case
colnames(tsumoto_c) <- snakecase::to_any_case(colnames(tsumoto_c), case = c("snake"))
head(tsumoto_c) ## have wrong name using the auto package, need to rename some again by hands
tsumoto_c<-tsumoto_c %>% 
  dplyr::rename(
    c3=c_3,
    c4=c_4,
    sc170=sc_170
  ) 

#duplicated(tsumoto_c) | duplicated(tsumoto_c, fromLast = TRUE) 
tsumoto_c<-tsumoto_c %>% distinct(id,date, .keep_all = TRUE)
nrow(tsumoto_c) ##57545

##check na  missing values 
#head(is.na(tsumoto_c)) ## --> check value shows 'na'

## only contain useful columns:
tsumoto_c<-subset(tsumoto_c , select= c(id,tp,alb,ua,un,cre,t_bil,t_cho))
nrow(tsumoto_c) ##57545

#tsumoto_c <- na.omit(tsumoto_c) ## delete na values in table c 
nrow(tsumoto_c) ## 46150 

str(tsumoto_c)
## change data type from character to numeric: 
tsumoto_c$tp <- as.numeric(tsumoto_c$tp)
tsumoto_c$alb <-as.numeric(tsumoto_c$alb)
tsumoto_c$ua <- as.numeric(tsumoto_c$ua)
tsumoto_c$cre<- as.numeric(tsumoto_c$cre)
tsumoto_c$t_bil<- as.numeric(tsumoto_c$t_bil)
tsumoto_c$t_cho <- as.integer(tsumoto_c$t_cho)

## calculate the means based on row names: (provide an average number of test for each id)
## url for reference: https://stackoverflow.com/questions/26377840/average-of-multiple-rows-by-name-or-row-number-in-r

tsumoto_c2<-tsumoto_c %>% 
  group_by(id) %>% #grouped by Year variable 
  summarise_each(funs(mean=mean(., na.rm=TRUE))) 
head(tsumoto_c2) 
nrow(tsumoto_c2) ##1237

## left join tsumoto_ab and tsumoto_c2
#df= tsumoto_ab %>% left_join(tsumoto_c2,by="id")
tsumoto_abc<-merge(x = tsumoto_ab, y =tsumoto_c2 , by = "id", all.x = TRUE) 
#tsumoto_ab = separate_rows(tsumoto_ab,7,sep = ",") 
head(tsumoto_abc) 
nrow(tsumoto_abc) #768 rows 
ncol(tsumoto_abc) ##23 cols

tsumoto_abc = separate_rows(tsumoto_abc,8,sep = ",")
head(tsumoto_abc)
nrow(tsumoto_abc) #937 rows

#calculate age from exmination date and birthday:
##make data type from factor to date:
tsumoto_abc$examination_date<- as.Date(tsumoto_abc$examination_date)
tsumoto_abc$birthday<- as.Date(tsumoto_abc$birthday)
str(tsumoto_abc$birthday)

tsumoto_abc$age<-lubridate::time_length(difftime(tsumoto_abc$examination_date,tsumoto_abc$birthday), "years")


## check again and drop useless columns:
head(tsumoto_abc)
tsumoto_abc<-tsumoto_abc[, !(colnames(tsumoto_abc) %in% c("kct","rvvt","lac","symptoms","admission","alb_mean","ua_mean","un_mean","cre_mean"))]

##write the revised dataset into thrombosis.csv 
write.csv(tsumoto_abc,"thrombosis.csv",row.names=FALSE,na="")

