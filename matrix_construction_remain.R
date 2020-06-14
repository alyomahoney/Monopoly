# as it stands, the transition rows starting as the jail spaces are actually incorrect and need to be manually adjusted
transition_remain["0in_jail",] <- transition_remain["1in_jail",] <- transition_remain["2in_jail",] <- transition_remain["3in_jail",] <- ij0
transition_remain["in_jail1",] <- ij1
transition_remain["in_jail2",] <- ij2

# displaying the transition matrix
kable(data.frame(transition_remain),col.names = gsub("[.]", " ", colnames(transition_remain)),caption="Transition matrix when adopting the remain strategy") %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive")) %>% scroll_box(width = "100%", height = "500px",fixed_thead = T)

