# start by replicating the previous transition matrix
transition_escape <- transition_remain

# again, manually adjust the transition rows for the jail spaces
transition_escape["0in_jail",] <- transition_escape["1in_jail",] <- transition_escape["2in_jail",] <- transition_escape["3in_jail",] <- transition_remain["0visiting_jail",]

# exclude the last two states as when adopting the 'escape' strategy a player never stays in jail
transition_escape <- transition_escape[-122:-123,-122:-123]

# displaying the transition matrix
kable(data.frame(transition_escape),col.names = gsub("[.]", " ", colnames(transition_escape)),caption="Transition matrix when adopting the escape strategy") %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive")) %>% scroll_box(width = "100%", height = "500px",fixed_thead = T)