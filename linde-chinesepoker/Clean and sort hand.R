# Clean deck via dplyr, groupling like cards and possible hands together
cleaned = function(x) {
  x %>% 
    group_by(rank, value) %>% 
    summarise(freq = n())
}

# Sort User, Opponent1 and Opponent2 hands
sorted = function() {
  # these are all the sorted hands 
  user <<- split(cleaned(me), cleaned(me)$freq)
  opponent1 <<- split(cleaned(computer1), cleaned(computer1)$freq)
  opponent2 <<- split(cleaned(computer2), cleaned(computer2)$freq)
}

