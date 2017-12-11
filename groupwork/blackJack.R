blackjack <- function(){ 
  
  # Initialize Values
  endPlay = 0
  isRand = 0
  isDraw = 1
  a.val = 1
  isPlayAgain = 1
  init1 = 1
  init2 = 1
  
  score1 = 0
  score2 = 0
  
  # Create a loop that only stops when the user inputs 1 at the end of a game
  while (endPlay != 1){
    ################# INITIALIZING PLAYER 1 #################      
    
    # Start with how many cards total there will be in the deck. 
    cards <- rep(c(1:9, 13, 10, 10, 10, 10), times = 4)
    
    # Initializes game
    isRand <- readline(prompt = "Input 0 if you already have a hand or 1 if you'd like a random hand. ")
    while(isRand != 1 & isRand != 0){
      isRand <- readline(prompt = "ERROR! Please enter a valid input: ")
    }
    isRand <- as.integer(isRand)
    
    # Initializes hand if the player is choosing a random hand
    if (isRand == 1){
      init.hand <- sample(cards, 2, replace=FALSE)
    }
    # Otherwise, the player has to specify the hand
    init1 <- ifelse(isRand == 0, 
                    readline(prompt = "Give your first hand: "),
                    init.hand[1])
    
    while(init1 < 0 | (init1 > 10 & init1 != 13)){
      init1 <- readline(prompt = "ERROR! Please enter a valid input: ")
    }
    init1 <- as.integer(init1)
    
    init2 <- ifelse(isRand == 0, 
                    readline(prompt = "Give your second hand: "),
                    init.hand[2])
    while(init2 < 0 | (init2 > 10 & init2 != 13)){
      init2 <- readline(prompt = "ERROR! Please enter a valid input: ")
    }
    init2 <- as.integer(init2)
    
    # Save the hand (which still counts 13 as Ace); NOTE: THIS IS NOT THE CARD VALUE, JUST THE ACTUAL CARD
    hand1 <- c(init1, init2)
    print(paste("Card: ", hand1))
    # Take out the cards player 1 has
    cards[min(which(cards==init1))] = NA
    cards[min(which(cards==init2))] = NA
    
    # Keeps count of the number of aces 
    aces.count <- sum(hand1 == 13)
    
    # Function to ask about values for aces
    ace <- function(numAce){
      curAceVal <- c()
      ace.val <- 1
      while (numAce >= 1){
        ace.val <- readline(prompt = "You have an Ace! Please enter a value for it (NOTE THAT THIS IS BINDING): ")
        while(ace.val != 1 & ace.val != 11){
          ace.val <- readline(prompt = "ERROR! Please enter a valid input: ")
        }
        ace.val <- as.integer(ace.val)
        curAceVal <- c(ace.val, curAceVal)
        numAce = numAce - 1
      }
      return(curAceVal)
    }
    
    # Assigns values to aces if aces exist (this would be 0 if there are no aces)
    ace.vals <- ace(aces.count)
    
    # Keeps count of the values of the cards (not the cards themselves)
    curCards <- c(hand1[hand1 != 13], ace.vals)
    # Save the cards sum for player 1
    sum1 <- sum(curCards)
    
    ################# INITIALIZING PLAYER 2 #################  
    
    # Initializes player 2's hands
    init1_p2 <- NA
    init2_p2 <- NA

    while(is.na(init1_p2)){
      init1_p2 <- sample(cards, 1, replace=FALSE)
    }
    init1_p2 <- as.integer(init1_p2)
    cards[min(which(cards==init1_p2))] = NA
    
    while(is.na(init2_p2)){
      init2_p2 <- sample(cards, 1, replace=FALSE)
    }
    init2_p2 <- as.integer(init2_p2)
    cards[min(which(cards==init2_p2))] = NA
    
    hand2 <- c(init1_p2, init2_p2)
    
    # Make player 2 semi-intelligent. If it has an A and that will make the pair 21, then A=11. 
    # Otherwise, A will be 1 if an Ace exists. 
    aces.count2 <- sum(hand2[hand2 != 13])
    
    if (aces.count2 == 1 & (11 + sum(hand2[hand2 !=13]) <= 21)) {
      curCards2 <- c(11, hand2[hand2 != 13])
    } else if (aces.count2 == 1){
      curCards2 <- c(1, hand2[hand2 != 13])
    } else if (aces.count2 == 2){
      aces.vals2 <- c(1, 1)
      curCards2 <- c(aces.vals2)
    } else {
      aces.vals2 <- c()
      curCards2 <- c(hand2)
    }
    
    # Save the sum for P2
    sum2 <- sum(curCards2)
    
    # INITIAL CHECK OF ANY WINNERS
    
    if (sum2 > 21 && sum1 > 21){
      winner = "TIE" 
      end=1
    } else if (sum2 < 21 && sum1 > 21){
      winner = "PLAYER 2 WON."
      end=1
    } else if (sum1 == 21 && sum2 != 21){
      winner = "YOU WON."
      end=1
    } else if (sum1 != 21 && sum2 == 21){
      winner = "PLAYER 2 WON"
      end=1
    } else {
      print("GAME STARTING.")
      end=0
    }
    
    ################# PLAYER 1'S MOVE #################
    if (end == 0){
      # Function to ask to draw   
      askDraw <- function(){
        if (sum(is.na(cards)) != 52){
          isDraw <- readline(prompt = "Input 1 if you want to draw. Input 0 if not: ")
          while(isDraw != 1 & isDraw != 0){
            isDraw <- readline(prompt = "ERROR! Please enter a valid input: ")
          }
          isDraw <- as.integer(isDraw)
          return(isDraw)
        } else {
          print("No more cards left!")
          return(0)
        }
      }
      
      # Initialize draw value
      draw <- askDraw()
      
      # Player 1 Drawing
      while(draw == 1){
        newCard <- NA
        while(is.na(newCard)){
          newCard <- sample(cards, 1, replace = FALSE)
        }
        # Get a new card
        hand1 <- c(hand1, newCard)
        cards[min(which(cards==newCard))] = NA
        
        # Allow a value for ace if the new card is an Ace
        if (newCard == 13){
          new.aceVal <- ace(1)
          curCards <- c(curCards, new.aceVal)
        } else {
          curCards <- c(curCards, newCard)  
        }
        
        # print output of cards
        cards.msg <- paste("Card: ", hand1)
        print(cards.msg)
        values.msg <- paste("Value: ", curCards)
        print(values.msg)
        sum1 <- sum(curCards)
        # ask if player will draw
        draw <- askDraw() 
      }
      
      print("Player 2's turn now.")
      
      newCard2 <- NA
      # Player 2's turn (semi-intelligently)
      # Player 2 will only draw if the sum of its current cards is less than 20 
      while(sum2 < 15){
        # Keep drawing a new card until the card is not NA

        while(is.na(newCard2)) {
          newCard2 <- sample(cards,1, replace=FALSE)
        }
        hand2 <- c(hand2, newCard2)
        cards[min(which(cards==newCard2))] = NA
        # Any ace value drawn will automatically be counted as 1 
        if (newCard2 == 13){
          curCards2 <- c(curCards2, 1)
        } 
        else {
          curCards2 <- c(curCards2, newCard2)
        }
        # unless making it 11 will create 21
        if (newCard2 == 13 && (sum2 + 11 == 21)){
          curCards2 <- c(curCards2, 11)
        } else {
          curCards2 <- curCards2
        }
        sum2 <- sum(curCards2)  
      }
      
      # When player 1 and 2 are done, show the end results 
      print("GAME IS DONE.")
      print(paste("YOUR SUM: ", sum1))
      print(paste("PLAYER 2'S SUM: ", sum2))
      
      # CHECK WHO HAS WON
      if (sum2 > 21 && sum1 > 21){
        winner = "TIE" 
      } else if (sum2 <= 21 && sum1 > 21){
        winner = "PLAYER 2 WON."
      } else if (sum2 > 21 && sum1 <= 21){
        winner = "YOU WON."
      }
        else if (sum1 == 21 && sum2 != 21){
        winner = "YOU WON."
      } else if (sum1 != 21 && sum2 == 21){
        winner = "PLAYER 2 WON"
      } else if (sum1 > sum2){
        winner = "YOU WON."
      } else if (sum1 < sum2){
        winner = "PLAYER 2 WON."
      } else {
        winner = "TIE"
      }
      
    } else {
      print("GAME IS DONE.")
    }

    # save who won and keep score
    if (winner == "YOU WON."){
      score1 = score1 + 1
      score2 = score2 
    } else if (winner == "PLAYER 2 WON.") {
      score1 = score1
      score2 = score2 + 1
    } else {
      score1 = score1
      score2 = score2
    }
    
    
    # Print winner
    print(winner)
    
    isPlayAgain <- readline(prompt = "Enter 1 if you'd like to replay. Otherwise, enter 0: ")
    if (isPlayAgain == 0){
      endPlay = 1
    } else if (isPlayAgain == 1){
      endPlay = 0
    } else {
      # ERROR MESSAGE
      while (isPlayAgain != 0 & isPlayAgain != 1){
        isPlayAgain <- readline(prompt = "ERROR! Please enter either 1 if you'd like to replay or 0 if you'd like to end the game. ")
      }
      if (isPlayAgain == 0){
        endPlay = 1
      } else 
      {
        endPlay = 0
      }
    }
  }
  
  # make the score as a string that shows the user's scores and the 
  gameScoreMsg <- paste("YOUR SCORE: ", score1,". PLAYER 2 SCORE: ", score2,".")
  print(gameScoreMsg)
}
