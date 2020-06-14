# this function takes input s, the starting position of the piece (0 = go, 1 = old kent road, etc.)
# it returns a list containing three transition rows
# the first row assumes that no doubles have been thrown, the second assumes one double has just been thrown and the third assumes two doubles have just been thrown
# for example, rows(1)[[2]] returns the transition row when starting at old kent road given that exactly one double has been previously thrown

rows <- function(s) {
  
  # initialise empty vector to be filled in
  total <- empty
  
  # the first loop accumulates the probabilities for throwing non-doubles    
  for (i in 1:9) {
    
    temp <- empty
    
    if (str_detect(state_space_rep[i+3+s],"community_chest1")) {
      temp[1:40] <- community_chest_transition1*rolls[i]
      
    }else if (str_detect(state_space_rep[i+3+s],"community_chest2")) {
      temp[1:40] <- community_chest_transition2*rolls[i]
      
    }else if (str_detect(state_space_rep[i+3+s],"community_chest3")) {
      temp[1:40] <- community_chest_transition3*rolls[i]
      
    }else if (str_detect(state_space_rep[i+3+s],"chance1")) {
      temp[1:40] <- chance_transition1*rolls[i]
      
    }else if (str_detect(state_space_rep[i+3+s],"chance2")) {
      temp[1:40] <- chance_transition2*rolls[i]
      
    }else if (str_detect(state_space_rep[i+3+s],"chance3")) {
      temp[1:40] <- chance_transition3*rolls[i]
      
    }else {
      temp[paste0("0",state_space_rep[i+3+s])] <- rolls[i]
    } 
    
    total <- total + temp
  }
  
  # the second loop accumulates the probabilities for throwing doubles
  for (i in 10:15) {
    
    temp <- empty
    
    if (str_detect(state_space_rep[2*i-17+s],"community_chest1")) {
      temp[41:80] <- community_chest_transition1*rolls[i]
      
    }else if (str_detect(state_space_rep[2*i-17+s],"community_chest2")) {
      temp[41:80] <- community_chest_transition2*rolls[i]
      
    }else if (str_detect(state_space_rep[2*i-17+s],"community_chest3")) {
      temp[41:80] <- community_chest_transition3*rolls[i]
      
    }else if (str_detect(state_space_rep[2*i-17+s],"chance1")) {
      temp[41:80] <- chance_transition1*rolls[i]
      
    }else if (str_detect(state_space_rep[2*i-17+s],"chance2")) {
      temp[41:80] <- chance_transition2*rolls[i]
      
    }else if (str_detect(state_space_rep[2*i-17+s],"chance3")) {
      temp[41:80] <- chance_transition3*rolls[i]
      
    }else {
      temp[paste0("1",state_space_rep[2*i-17+s])] <- rolls[i]
    } 
    
    total <- total + temp
  }
  
  # 'total' now contains the transition rows given that no doubles were previously thrown
  # 'total1' and 'total2' will account for one and two doubles having been thrown previously respectively
  total1 <- empty
  total1[1:40] <- total[1:40]
  total1[81:120] <- total[41:80]
  
  total2 <- empty
  total2[1:40] <- total[1:40]
  total2["3in_jail"] <- 1/6 # 3 consecutive doubles lands a player in jail
  
  list(total,total1,total2) # return three rows as a list
  
}