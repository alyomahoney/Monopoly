set1 <- "hsl(29, 69%, 34%)"
set2 <- "hsl(205, 82%, 73%)"
set3 <- "hsl(297, 77%, 47%)"
set4 <- "hsl(35, 100%, 54%)"
set5 <- "hsl(0, 76%, 49%)"
set6 <- "hsl(60, 88%, 60%)"
set7 <- "hsl(111, 74%, 39%)"
set8 <- "hsl(218, 62%, 33%)"
colour_sets <- c(set1,set2,set3,set4,set5,set6,set7,set8)
colour_label <- c("Brown","Light blue","Pink/purple","Orange","Red","Yellow","Green","Dark blue")

prop_col_remain <- data.frame(tidy_ss_remain) %>% 
  mutate(Colour = factor(colour_simple,levels=unique(colour_simple))) %>%
  group_by(Colour) %>%
  summarize(Proportion=sum(tidy_ss_remain)) %>%
  filter(Colour %in% c("brown","skyblue2","purple","orange","red","yellow","green","blue")) %>%
  mutate(Colour=factor(colour_label,levels=unique(colour_label)))


# proportion of time spent at each colour

prop_col_remain %>%
  ggplot(aes(Colour, Proportion, fill=Colour)) +
  theme_gdocs() +
  geom_bar(stat="identity") +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank()) +
  scale_fill_manual(values=c("#884403","skyblue2","#CC0099","orange","#EE0000","yellow","#44BB11","#003399"))
  
