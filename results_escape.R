# initialise the markov chain
transition_matrix_escape <- new("markovchain", transitionMatrix=transition_escape)

# create a data frame with the stationary distribution
large_ss_escape <- steadyStates(transition_matrix_escape) %>% t() %>% data.frame()

# include the state names with some basic string processing to remove the numbers indicating the amount of previously thrown doubles
tidy_ish_ss_escape <- large_ss_escape %>% mutate(state=str_replace(str_replace(rownames(large_ss_escape),"^\\d?",""),"in_jail\\d?","in_jail"))

# the final stationary distribution
tidy_ss_escape <- tapply(tidy_ish_ss_escape$., tidy_ish_ss_escape$state, FUN=sum)[state_space_simple]

# rename with tidy labels
names(tidy_ss_escape) <- state_space_proper

# display the stationary distribution
kable(data.frame(tidy_ss_escape),col.names = gsub("[.]", " ", names(data.frame("Proportion of Time Spent" = tidy_ss_escape)))) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive")) %>% scroll_box(width = "50%", height = "500px",fixed_thead = T)