tab_properties
long_run_properties

col_set <- c(rep("Brown",2),rep("Light blue",3),rep("Pink/purple",3),rep("orange",3),rep("Red",3),rep("Yellow",3),rep("Green",3),rep("Dark blue",2))

ipr_set <- ipr_properties %>% mutate(Colour=factor(col_set,levels=unique(col_set))) %>% group_by(Colour)%>% summarise(Single=sum(Single),
                                                                            Set=sum(Set),
                                                                            One_house=sum(One_house),
                                                                            Two_houses=sum(Two_houses),
                                                                            Three_houses=sum(Three_houses),
                                                                            Four_houses=sum(Four_houses),
                                                                            Hotel=sum(Hotel))

building_cost_set <- c(100,150,300,300,450,450,600,400)

return_inv_set <- data.frame("First_House"=rep(0,8),"Second_House"=rep(0,8),"Third_House"=rep(0,8),"Fourth_House"=rep(0,8),"Hotel"=rep(0,8))


for (j in 1:8) {
  for (i in 1:5) {
    return_inv_set[j,i] <- building_cost_set[j]/(ipr_set[j,i+3]-ipr_set[j,i+2])
  }
}

return_inv_set <- cbind(Colour=unique(col_set),return_inv_set)

kable(return_inv_set,col.names = gsub("[_]", " ", names(return_inv_set))) %>%
  kable_styling(fixed_thead=T, bootstrap_options = c("hover", "condensed", "responsive")) %>%  
  row_spec(c(1), color = "white", background = "hsl(29, 69%, 34%)") %>%
  row_spec(c(2), color = "black", background = "hsl(205, 82%, 73%)") %>%
  row_spec(c(3), color = "white", background = "hsl(297, 77%, 47%)") %>%
  row_spec(c(4), color = "black", background = "hsl(35, 100%, 54%)") %>%
  row_spec(c(5), color = "white", background = "hsl(0, 76%, 49%)") %>%
  row_spec(c(6), color = "black", background = "hsl(60, 88%, 60%)") %>%
  row_spec(c(7), color = "white", background = "hsl(111, 74%, 39%)") %>%
  row_spec(c(8), color = "white", background = "hsl(218, 62%, 33%)")





temp_ret_inv_set <- cbind(return_inv_set %>% mutate(x=1:8),Cost=building_cost_set) %>% gather(House,Rolls,First_House:Hotel)
temp_ret_inv_set <-  mutate(temp_ret_inv_set,House=factor(House,unique(House)))
ggplot(temp_ret_inv_set,aes(x,Rolls,col=House)) +
  theme_gdocs() +
  geom_line(size=1.5) +
  scale_y_continuous(trans="log10") +
  scale_x_continuous(breaks=1:8, labels=unique(col_set)) +
  theme(axis.text.x = element_text(angle=90,hjust=1)) +
  scale_colour_discrete(name = "Building", labels = gsub("_"," ",unique(temp_ret_inv_set$House))) +
  theme(axis.title.x = element_blank()) +
  ggtitle("Expected Number of Rolls to See Return on Investment")
