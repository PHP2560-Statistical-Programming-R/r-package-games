#install.packages("dplyr")
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
