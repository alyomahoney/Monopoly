# initialise the markov chain
transition_matrix_remain <- new("markovchain", transitionMatrix=transition_remain)

# create a data frame with the stationary distribution
large_ss_remain <- steadyStates(transition_matrix_remain) %>% t() %>% data.frame()

# include the state names with some basic string processing to remove the numbers indicating the amount of previously thrown doubles
tidy_ish_ss_remain <- large_ss_remain %>% mutate(state=str_replace(str_replace(rownames(large_ss_remain),"^\\d?",""),"in_jail\\d?","in_jail"))

# the final stationary distribution
tidy_ss_remain <- tapply(tidy_ish_ss_remain$., tidy_ish_ss_remain$state, FUN=sum)[state_space_simple]

# rename with tidy labels
names(tidy_ss_remain) <- state_space_proper

# display the stationary distribution
kable(data.frame(tidy_ss_remain),col.names = gsub("[.]", " ", names(data.frame("Proportion of Time Spent" = tidy_ss_remain)))) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive")) %>% scroll_box(width = "50%", height = "500px",fixed_thead = T)