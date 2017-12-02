library(dplyr)
#source("Setup and pick deck.R")
#source("Clean and sort hand.R")
#source("Helper functions.R")

# ***************************************** START GAME **************************************
chinese.poker = function(x = user) {

# Function to 1) determine who starts the game, 2) starts the game
start.game = function(x) {
  sorted()
  print(x)
  user.playcard()
}

# ********************************* RUN THIS TO PLAY GAME  ************************************


# ******************************** SETUP and PICK DECK *************************

install.packages("dplyr")
library(dplyr)

initiate = matrix(c(rep(c(2:10, "J", "Q", "K", "A"), 4),
                    rep(c("Clubs", "Diamonds", "Hearts", "Spades"), rep(13,4)),
                    rep(c(2:14), 4)),
                  ncol = 3, dimnames = list(NULL, c("rank", "suit", "value")))
deck = as.data.frame(rbind(initiate, c("Little Joker", "Joker", 20), c("Big Joker", "Joker", 30)),
                     stringsAsFactors = FALSE)
facecards = c("J", "Q", "K", "A", "J,J", "Q,Q", "K,K", "A,A", "J,J,J", "Q,Q,Q", "K,K,K", "A,A,A",
              "J,J,J,J", "Q,Q,Q,Q", "K,K,K,K", "A,A,A,A", "Little Joker", "Big Joker")

deal_hand = deck[sample(1:54, 54, replace = FALSE),]

pick.deck = function() {
  # shuffle and split deck
  A = deal_hand[1:18, ]
  B = deal_hand[19:36, ]
  C = deal_hand[37:54, ]
  # user picks one of three randomly dealt hands
  n = readline(prompt = "Enter name (player1, player2 or player3): ")
  if (n == "player1") {
    me <<- A
    computer1 <<- B
    computer2 <<- C
    return(me)
  } else if (n == "player2") {
    me <<- B
    computer1 <<- A
    computer2 <<- C
    return(me)
  } else {
    me <<- C
    computer1 <<- A
    computer2 <<- B
    return(me)
  }
}
my.deck = print(pick.deck())

# *********************** CLEAN AND SORT HAND *************************

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

# ********************************* HELPER FUNCTIONS **************************
# Intermediary functions for discarding played cards

# DELETING CARDS

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

# CHECKING WINS

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

  print(start.game(x))
}