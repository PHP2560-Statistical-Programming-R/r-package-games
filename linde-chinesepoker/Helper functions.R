# Intermediary functions for discarding played cards 

# ****************************** DELETING CARDS **************************

# User delete card 
user.delete = function () {
  a = length(turn)
  b = turn[1]
  n = which(user[[a]][,2] == b)
  user[[a]] = user[[a]][-n,]
  user <<- user 
}

# Opponent 1 delete card 
opp1.delete = function () {
  a = length(opp1move)
  b = opp1move[1]
  n = which(opponent1[[a]][,2] == b)
  opponent1[[a]] = opponent1[[a]][-n,]
  opponent1 <<- opponent1 
}

# Opponent 2 delete card 
opp2.delete = function () {
  a = length(opp2move)
  b = opp2move[1]
  n = which(opponent2[[a]][,2] == b)
  opponent2[[a]] = opponent2[[a]][-n,]
  opponent2 <<- opponent2 
}

# ************************* CHECKING WINS *****************************

# Did User Win?
user.win = function() {
  count = as.vector(lapply(user, nrow))
  if (all(count == 0)) {
    print(" HOORAY!! YOU WON!!")
  } else {
    print(user)
  }
}

# Did Opponent 1 Win?
opp1.win = function() {
  count = as.vector(lapply(opponent1, nrow))
  if (all(count == 0)) {
    print("Opponent 1 WINS!!")
  } else {
    print(opp1move)
  }
}

# Did Opponent 2 Win?
opp2.win = function() {
  count = as.vector(lapply(opponent2, nrow)) # check if Opponent 2 won
  if (all(count == 0)) {
    print("Opponent 2 WINS!!")
  } else {
    print(opp2move) 
  }
}
