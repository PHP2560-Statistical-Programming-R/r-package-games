
# Function to call start.game()
chinese.poker = function(){
  print(start.game())
}

# Function to start the game
start.game = function() {
  sorted()
  print(user)
  user.playcard()
}

# *** SETUP and PICK DECK ***

# initialize a deck of cards
initiate = matrix(c(rep(c(2:10, "J", "Q", "K", "A"), 4),
                    rep(c("Clubs", "Diamonds", "Hearts", "Spades"), rep(13,4)),
                    rep(c(2:14), 4)),
                  ncol = 3, dimnames = list(NULL, c("rank", "suit", "value")))
deck = as.data.frame(rbind(initiate, c("Little Joker", "Joker", 20), c("Big Joker", "Joker", 30)),
                     stringsAsFactors = FALSE)
facecards = c("J", "Q", "K", "A", "J,J", "Q,Q", "K,K", "A,A", "J,J,J", "Q,Q,Q", "K,K,K", "A,A,A",
              "J,J,J,J", "Q,Q,Q,Q", "K,K,K,K", "A,A,A,A", "Little Joker", "Big Joker")

# shuffles the deck of cards
deal_hand = deck[sample(1:54, 54, replace = FALSE),]

# this function allows theuser to pick any one of three randomly shuffled deck of cards
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

# *** CLEAN AND SORT HAND ***
library(dplyr)

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

# *** HELPER FUNCTIONS ***
# Intermediary functions for discarding played cards

# DELETING CARDS

# User discards played card
user.delete = function () {
  a = length(turn)
  b = turn[1]
  n = which(user[[a]][,2] == b)
  user[[a]] = user[[a]][-n,]
  user <<- user
}

# Opponent 1 deletes played card
opp1.delete = function () {
  a = length(opp1move)
  b = opp1move[1]
  n = which(opponent1[[a]][,2] == b)
  opponent1[[a]] = opponent1[[a]][-n,]
  opponent1 <<- opponent1
}

# Opponent 2 deletes played card
opp2.delete = function () {
  a = length(opp2move)
  b = opp2move[1]
  n = which(opponent2[[a]][,2] == b)
  opponent2[[a]] = opponent2[[a]][-n,]
  opponent2 <<- opponent2
}

# CHECKING WINS

# check if User won
user.win = function() {
  count = as.vector(lapply(user, nrow))
  if (all(count == 0)) {
    print(" HOORAY!! YOU WON!!")
  } else {
    print(user)
  }
}

# check if Opponent 1 won
opp1.win = function() {
  count = as.vector(lapply(opponent1, nrow))
  if (all(count == 0)) {
    print("Opponent 1 WINS!!")
  } else {
    print(opp1move)
  }
}

# check if Opponent 2 won
opp2.win = function() {
  count = as.vector(lapply(opponent2, nrow)) # check if Opponent 2 won
  if (all(count == 0)) {
    print("Opponent 2 WINS!!")
  } else {
    print(opp2move)
  }
}
# *** USER's TURN  ***

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

# *** OPPONENT 1's turn ***

# Check if Opponent 1 has a card to play
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

# *** OPPONENT 2's turn ***

# Checks if Opponent 2 has a card to play
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
