library(dplyr)
source("Setup and pick deck.R")
source("Clean and sort hand.R")
source("Helper functions.R")

# ***************************************** START GAME **************************************

# Function to 1) determine who starts the game, 2) starts the game
start.game = function() {
  sorted()
  print(user)
  user.playcard()
}

# ********************************* RUN THIS TO PLAY GAME  ************************************

print(start.game())

# ************************************  USER  *************************************

# User asked if he/she wants to check her current hand
user.check = function() {
  check = readline(prompt = "Do you want to check your current hand? ")
  if (check == "yes") {
    print(user) 
    user.playcard() 
  } else {
    user.playcard() 
  }
}

# User plays card 
user.playcard = function() {
  turn = readline(prompt = "Your turn, enter a hand from your deck: ")
  if (turn %in% facecards) {
    turn = unlist(strsplit(turn, ",")) 
    turn <<- rep(as.integer(deck[which(deck[,1] == turn[1])[1],]$value), length(turn))
    user.delete()
    user.win()
    } else {
      turn <<- as.integer(unlist(strsplit(turn, ",")))
      user.delete()
      user.win()
      opponent1.check()
    }
}

# ************************************** OPPONENT 1 *************************************

# Check if Opponent 1 1) has a card to play, and if 2) he/she has already won 
opponent1.check = function() {
  hand = length(turn)
  if ((is.null(lapply(opponent1, nrow)[hand][[1]])) | is.null(opponent1[hand])) {
    print("Opponent 1 passes")
    opponent2.check() 
    } else {
        opp1.filter = 
          data.frame(lapply(opponent1[[hand]][,2], as.numeric)) %>%
          filter(value > turn[1]) 
        if (nrow(opp1.filter) == 0) {
          print("Opponent 1 passes") 
          opponent2.check() 
        } else {
            opponent1.play() 
          }
      }
}

# Opponent 1 chooses and plays a card
opponent1.play = function() {
  hand = length(turn)
  opp1.filter = 
    data.frame(lapply(opponent1[[hand]][,2], as.numeric)) %>%
      filter(value > turn[1])
  if (nrow(opp1.filter) == 0) {
    print("Opponent 1 passes") 
    opponent2.check()
    } else {
      opp1move = sample(rep(opp1.filter[[1]], 3), 1)
      opp1move <<- rep(as.integer(opp1move), hand)
      opp1.delete()
      opp1.win()
      opponent2.check()
    }
}

# ************************************* OPPONENT 2 *************************************

# Checks if Opponent 2 1) has a card to play, and 2) if he/she has already won 
opponent2.check = function() {
  hand = length(opp1move)
  if ((is.null(lapply(opponent2, nrow)[hand][[1]])) | is.null(opponent1[hand])) {
    print("Opponent 2 passes")
    user.check() 
    } else {
        opp2.filter = 
          data.frame(lapply(opponent2[[hand]][,2], as.numeric)) %>%
            filter(value > opp1move[1]) 
        if (nrow(opp2.filter) == 0) {
          print("Opponent 2 passes")
          user.check() 
          } else {
            print("new round")
            opponent2.play() 
          }
        }
}

# Opponent 2 chooses and plays a card
opponent2.play = function() {
  hand = length(turn)
  opp2.filter = 
    data.frame(lapply(opponent2[[hand]][,2], as.numeric)) %>%
      filter(value > opp1move[1])
  if (nrow(opp2.filter) == 0) {
    print("Opponent 2 passes") 
    user.check() 
    } else {
      opp2move = sample(rep(opp2.filter[[1]], 3), 1)
      opp2move <<- rep(as.integer(opp2move), hand)
      opp2.delete()
      opp2.win()
      user.check() 
      }
}
