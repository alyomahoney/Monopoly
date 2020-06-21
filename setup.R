# define all the spaces on the board (excluding 'go to jail' since a player cant end up there)
state_space_simple <- c("go","old_kent_road","community_chest1","whitechapel_road","income_tax",
                        "king's_cross_station","the_angel,_islington","chance1","euston_road","pentonville_road",
                        "visiting_jail","pall_mall","electric_company","whitehall","northumberland_avenue",
                        "marylebone_station","bow_street","community_chest2","marlborough_street","vine_street",
                        "free_parking","strand","chance2","fleet_street","trafalgar_square",
                        "fenchurch_st._station","leicester_square","coventry_street","water_works","piccadilly","in_jail",
                        "regent_street","oxford_street","community_chest3","bond_street","liverpool_st._station",
                        "chance3","park_lane","super_tax","mayfair")

# define each state for number of doubles previously rolled.
# state_space_x defines each state given x doubles have been rolled prior
state_space0 <- paste0("0",state_space_simple)
state_space1 <- paste0("1",state_space_simple)
state_space2 <- paste0("2",state_space_simple)

# entire state space
# in_jailx denotes the state space in which there have been x unsuccessful attempts to escape jail
state_space <- c(state_space0,state_space1,state_space2,"3in_jail","in_jail1","in_jail2") 

# transition probabilities after landing on community chest
community_chest_transition1 <-community_chest_transition2 <- community_chest_transition3 <- rep(0,40)
names(community_chest_transition1) <- names(community_chest_transition2) <- names(community_chest_transition3) <- state_space_simple

# probabilities based on the cards in each deck
community_chest_transition1[c("go","in_jail","community_chest1")] <- c(1/16,1/16,14/16)
community_chest_transition2[c("go","in_jail","community_chest2")] <- c(1/16,1/16,14/16)
community_chest_transition3[c("go","in_jail","community_chest3")] <- c(1/16,1/16,14/16)

# transition probabilities after landing on chance
chance_transition1 <- chance_transition2 <- chance_transition3 <- rep(0,40)
names(chance_transition1) <- names(chance_transition2) <- names(chance_transition3) <- state_space_simple

# probabilities based on the cards in each deck
chance_transition1[c("go","income_tax","electric_company","in_jail","marylebone_station",
                     "pall_mall","trafalgar_square","king's_cross_station","mayfair","chance1")] <- c(1/16,1/16,1/16,1/16,2/16,1/16,1/16,1/16,1/16,6/16)
chance_transition2[c("go","vine_street","water_works","in_jail","fenchurch_st._station",
                     "pall_mall","trafalgar_square","king's_cross_station","mayfair","chance2")] <- c(1/16,1/16,1/16,1/16,2/16,1/16,1/16,1/16,1/16,6/16)
chance_transition3[c("go","community_chest3","electric_company","in_jail",
                     "king's_cross_station","pall_mall","trafalgar_square","mayfair","chance3")] <- c(1/16,1/16,1/16,1/16,3/16,1/16,1/16,1/16,6/16)


# initialise empty named vector
empty <- rep(0,123)
names(empty) <- state_space

# define probabilities of dice outcomes (4 = 1+3 or 3+1, 4d = 2+2)
rolls <- c(p_3  = 2/36,
           p_4  = 2/36,
           p_5  = 4/36,
           p_6  = 4/36,
           p_7  = 6/36,
           p_8  = 4/36,
           p_9  = 4/36,
           p_10 = 2/36,
           p_11 = 2/36,
           p_2d = 1/36,
           p_4d = 1/36,
           p_6d = 1/36,
           p_8d = 1/36,
           p_10d= 1/36,
           p_12d= 1/36)

# extended simple state space used for the main function 'rows'
state_space_rep    <- c("go","old_kent_road","community_chest1","whitechapel_road","income_tax",
                        "king's_cross_station","the_angel,_islington","chance1","euston_road","pentonville_road",
                        "visiting_jail","pall_mall","electric_company","whitehall","northumberland_avenue",
                        "marylebone_station","bow_street","community_chest2","marlborough_street","vine_street",
                        "free_parking","strand","chance2","fleet_street","trafalgar_square",
                        "fenchurch_st._station","leicester_square","coventry_street","water_works","piccadilly",
                        "in_jail","regent_street","oxford_street","community_chest3","bond_street","liverpool_st._station",
                        "chance3","park_lane","super_tax","mayfair",
                        "go","old_kent_road","community_chest1","whitechapel_road","income_tax",
                        "king's_cross_station","the_angel,_islington","chance1","euston_road","pentonville_road",
                        "visiting_jail","pall_mall","electric_company","whitehall","northumberland_avenue",
                        "marylebone_station","bow_street","community_chest2","marlborough_street","vine_street",
                        "free_parking","strand","chance2","fleet_street","trafalgar_square",
                        "fenchurch_st._station","leicester_square","coventry_street","water_works","piccadilly",
                        "in_jail","regent_street","oxford_street","community_chest3","bond_street","liverpool_st._station",
                        "chance3","park_lane","super_tax","mayfair","go")

# defining the colour of each space
colour_simple <- c("tan","brown","aquamarine","brown","brown1","black","skyblue2","gold4","skyblue2","skyblue2",
                   "grey","purple","bisque3","purple","purple","black","orange","gold4","orange","orange",
                   "lightpink","red","aquamarine","red","red","black","yellow","yellow","bisque3","yellow",
                   "grey","green","green","aquamarine","green","black","gold4","blue","brown1","blue")