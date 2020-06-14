simpleCap <- function(x) {
  s <- strsplit(x, " ")[[1]]
  paste(toupper(substring(s, 1,1)), substring(s, 2),
        sep="", collapse=" ")
}

state_space_proper <- str_replace_all(state_space_simple,"_"," ")

for (i in 1:length(state_space_proper)) {
  state_space_proper[i] <- simpleCap(state_space_proper[i])
}

state_space_proper <- str_replace(state_space_proper,"([a-z]*)(\\d)","\\1 \\2")