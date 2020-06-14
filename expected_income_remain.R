inc_brown <- c(2,4)
inc_lblue <- c(6,6,8)
inc_purple <- c(10,10,12)
inc_orange <- c(14,14,16)
inc_red <- c(18,18,20)
inc_yellow <- c(22,22,24)
inc_green <- c(26,26,28)
inc_dblue <- c(35,50)

inc_single <- c(inc_brown,inc_lblue,inc_purple,inc_orange,inc_red,inc_yellow,inc_green,inc_dblue)

inc_set <- inc_single*2

library(rvest) # read_html
url <- "http://www.jdawiseman.com/papers/trivia/monopoly-rents.html" # accessed 13/06/2020
h <- read_html(url)
class(h)
h
tab <- h %>% html_nodes("table") 
tab <- html_table(tab[[2]])

names(tab) <- tab[1,]
tab <- tab[-1,]

ind <- str_detect(tab$Site,"^\\d*$")
tab_properties <- tab[ind,]
colnames(tab_properties) <- c("Property","Cost","Mortgage","Single","One_house","Two_houses","Three_houses","Four_houses","Hotel")
tab_properties <- tab_properties %>% mutate(Set=as.numeric(Single)*2,
                                       Cost=as.numeric(Cost),
                                       Mortgage=as.numeric(Mortgage),
                                       Single=as.numeric(Single),
                                       One_house=as.numeric(One_house),
                                       Two_houses=as.numeric(Two_houses),
                                       Three_houses=as.numeric(Three_houses),
                                       Four_houses=as.numeric(Four_houses),
                                       Hotel=as.numeric(Hotel)) %>% select(c(1:4,10,5:9))


ind <- str_detect(tab$Site,"25 or 50")
tab_stations <- tab[ind,]

ind <- str_detect(tab$Site,"dice")
tab_utilities <- tab[ind,]
