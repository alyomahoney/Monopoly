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
tab_properties$Property[3] <- "The Angel, Islington"
tab_properties$Property[12] <- "Strand"

long_run_properties <- tidy_ss_remain[names(tidy_ss_remain)%in%tab_properties$Property]

ipr_properties <- cbind(Property=tab_properties$Property,tab_properties[-1:-3]*tidy_ss_remain[names(tidy_ss_remain)%in%tab_properties$Property])

building_cost <- c(rep(50,5),rep(100,6),rep(150,6),rep(200,5))
names(building_cost) <- tab_properties$Property

return_inv <- data.frame("First_House"=rep(0,22),"Second_House"=rep(0,22),"Third_House"=rep(0,22),"Fourth_House"=rep(0,22),"Hotel"=rep(0,22))

for (j in 1:22) {
  for (i in 1:5) {
    return_inv[j,i] <- building_cost[j]/(ipr_properties[j,i+3]-ipr_properties[j,i+2])
  }
}

return_inv <- cbind(Property=tab_properties$Property,return_inv)

kable(return_inv,col.names = gsub("[_]", " ", names(return_inv))) %>%
  kable_styling(fixed_thead=T, bootstrap_options = c("hover", "condensed", "responsive")) %>%  
  row_spec(c(1,2), color = "white", background = "hsl(29, 69%, 34%)") %>%
  row_spec(c(3:5), color = "black", background = "hsl(205, 82%, 73%)") %>%
  row_spec(c(6:8), color = "white", background = "hsl(297, 77%, 47%)") %>%
  row_spec(c(9:11), color = "black", background = "hsl(35, 100%, 54%)") %>%
  row_spec(c(12:14), color = "white", background = "hsl(0, 76%, 49%)") %>%
  row_spec(c(15:17), color = "black", background = "hsl(60, 88%, 60%)") %>%
  row_spec(c(18:20), color = "white", background = "hsl(111, 74%, 39%)") %>%
  row_spec(c(21,22), color = "white", background = "hsl(218, 62%, 33%)") %>%
  scroll_box(width = "100%", height = "700px") 


temp_ret_inv <- cbind(return_inv %>% mutate(x=1:22),Cost=building_cost) %>% gather(House,Rolls,First_House:Hotel)
temp_ret_inv <-  mutate(temp_ret_inv,House=factor(House,unique(House)))
ggplot(temp_ret_inv,aes(x,Rolls,col=House)) +
  theme_gdocs() +
  geom_line(size=1.5) +
  scale_y_continuous(trans="log10") +
  scale_x_continuous(breaks=1:22, labels=tab_properties$Property) +
  theme(axis.text.x = element_text(angle=90,hjust=1)) +
  scale_colour_discrete(name = "Building", labels = gsub("_"," ",unique(temp_ret_inv$House))) +
  theme(axis.title.x = element_blank()) +
  ggtitle("Expected Number of Rolls to See Return on Investment")



#####

ind <- str_detect(tab$Site,"25 or 50")
tab_stations <- tab[ind,]

ind <- str_detect(tab$Site,"dice")
tab_utilities <- tab[ind,]
