# this script handles the intricacies involved when dealing with jail

# store all transition rows in an array
all_rows <- sapply(0:39,rows)

# an empty matrix which will later store the transition probabilities
transition_remain <- matrix(rep(0,123^2),ncol=123,dimnames=list(state_space,state_space))

# filling out the transition matrix
for (j in 1:3) {
  for (i in 1:40) {
    transition_remain[i+(j-1)*40,] <- all_rows[j,i][[1]]
  }
}

# initialise transition row for when starting at visiting jail (which is the same as leaving jail)
vj0 <- transition_remain["0visiting_jail",]

# 2d
ij_2d <- empty
ij_2d["0electric_company"] <- rolls["p_2d"]

# 4d
ij_4d <- empty
ij_4d["0northumberland_avenue"] <- rolls["p_4d"]

# 6d
ij_6d <- empty
ij_6d["0bow_street"] <- rolls["p_6d"]

# 8d
ij_8d <- empty
ij_8d["0marlborough_street"] <- rolls["p_8d"]

# 10d
ij_10d <- empty
ij_10d["0free_parking"] <- rolls["p_10d"]

# 12d
ij_12d <- empty
ij_12d[1:40] <-chance_transition2*rolls["p_12d"]

# odd
ij_odd <- empty
ij_odd["in_jail1"] <- 5/6

# constructing the transition row for first throw in jail (regardless of number of prior doubles)
ij0 <- ij_2d+ij_4d+ij_6d+ij_8d+ij_10d+ij_12d+ij_odd

# transition row for second throw in jail
ij1 <- empty
ij1[1:40] <- ij0[1:40]
ij1["in_jail2"] <- 5/6

# transition row for third throw in jail
ij2 <- empty
ij2[1:40] <- vj0[1:40]+vj0[41:80] # throwing a double to escape jail does not permit another throw