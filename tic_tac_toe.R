library(animation)

# ********This file contains all functions for tic tac toe ******* #
# ********The user should only be running ticTacToe() and clearBoard() ******#

#This function sets up the board or is used to redraw it
drawBoard <- function(board) { # Draw the board
  library(animation)
  
  #Set up symbols vector and create the plot margins
  symbols <- c("X", " ", "O") 
  par(mar = rep(0,4)) 
  
  #Create plot for board: 30 pixels by 30 pixels
  plot.new()
  plot.window(xlim = c(0,30), ylim = c(0,30))
  abline(h = c(10, 20), col="black", lwd = 3)
  abline(v = c(10, 20), col="black", lwd = 3)
  
  #board var will have -1 for comp, 0 for unused, 1 for human
  #so to represent these as x and o, add 2 to index symbols vector
  #and call this "pieces"
  pieces <- symbols[board + 2]
  scaleFactor <- 5
  
  #R text function adds text to a plot
  x_coords <- c(5,15,25,5,15,25)
  y_coords <- c(25,25,25,15,15,15,5,5,5)
  text(x=x_coords, 
       y= y_coords, 
       labels = pieces, 
       cex = scaleFactor)
}


# Human player enters a move
# This function takes in 'game' which is a vector size 9 of 
# the current moves and allows the player to move to one
# of those empty spots using the locator() function
playerMove <- function(game) {
  print("Your move. Click a square!")
  empty_spots <- which(game == 0)
  selected <- 0
  while (!selected %in% empty_spots) {
    coordinate <- locator(n = 1) #get user's click
    selected <- getSelectedSquare(coordinate) #will be 1-9
  }
  return (selected)
}

# This function checks the game board to see who
# has won and returns the score of the winner
checkScore <- function(game, player) {
  board <- t(matrix(game, nrow = 3))
  flipped_board <- t(apply(board, 2, rev))
  
  diag1 <- sum(diag(board))
  diag2 <- sum(diag(flipped_board))
  horizontal <- rowSums(board)
  vertical <- colSums(board)
  
  #Scores are sum of three contiguous squares
  scores <- c(horizontal, vertical, diag1, diag2)
  
  # Determine best score (depends on who is playing: minimax)
  #if player is computer choose minimum score
  #if player is human choose maximum score
  minimax <- ifelse(player == -1, "min", "max") 
  topScore <- do.call(minimax, list(scores))
  if (abs(topScore) == 3) { #If sum to 3, winning: mark as 6/-6
    topScore <- topScore * 2
  }
  return (topScore)
}

# Determine computer move using minimax algorithm
computerMove <- function(game) {
  empty <- which(game == 0)
  player <- -1 #(computer)
  
  ##     Explanation of "possible" matrix   ##
  #This matrix holds SCORES based on possible moves
  #Rows are 1-10
      #Row 1 represents the immediate move
      #Rows 2-10 represent possible moves AFTER this move (+1)
  #Columns 1-9 represent possible empty squares right now
  #
  #Ex: row 1, col 3 has score if comp goes to square #3 now
  #    row 2, col 3 has score if comp goes to square #3 now then square #1
  #    row 5, col 6 has score if comp goes to square #6 now then square #4
  
  possible <- matrix(nrow = 10, ncol = 9, data = 0)
  for (i in empty) {
    #store the comp's potential moves
    tempGame <- game
    tempGame[i] <- player
    
    #consider all moves & fill in possible
    possible[1, i] <- checkScore(tempGame, player)
    tempEmpty <- which(tempGame == 0)
    
    for (j in tempEmpty) {
      tempTempGame <- tempGame
      tempTempGame[j] <- -player
      possible[(j + 1), i] <- checkScore(tempTempGame, -player)
    }
  }
  
  if (!any(abs(possible[1,]) == 6)) { #If no immediate winning move,
    #Look at OPPONENT's possible moves
    minimax <- ifelse(player == -1, "max", "min")
    opponentBest <- apply(possible[-1,], 1, minimax)
    possible[1,] <- possible[1,] * -player * opponentBest
  }

  minimax <- ifelse(player == -1, "which.min", "which.max") # Minimax
  move <- do.call(minimax, list(possible[1,])) # Select best move
  return(move)
}

# Main game function
#Player 1 (human) Player -1 (computer)
ticTacToe <- function() {
  game <- rep(0, 9) 
  beenWon <- FALSE 
  player <- 1 # First player
  drawBoard(game)
  while (0 %in% game & !beenWon) { # Keep playing until win or full board
    if(player == 1) { #Human
      move <- playerMove(game)
    }
    else # Computer
      move <- computerMove(game)
    game[move] <- player # Change board
    drawBoard(game)
    
    #The game has been won if checking score gives a value of 6 or -6
    beenWon <- max(checkScore(game, 1), abs(checkScore(game, -1))) == 6 
    player <- -player #Switch player
  }
  print("Game Over!")
}

clearBoard <- function() {
  plot.new()
  plot.window(xlim = c(0,30), ylim = c(0,30))
  abline(h = c(10, 20), col="black", lwd = 3)
  abline(v = c(10, 20), col="black", lwd = 3)
}


getSelectedSquare <- function(coordinate) {
  selected <- 0
  x <- coordinate$x
  y <- coordinate$y
  
  if(0 < x && x<10) { #left column
    if (20 < y && y <30) { #top bar
      selected <- 1
    }
    else if (10 < y && y<20) {
      selected <- 4
    } 
    else {
      selected <- 7
    }}
  
  else if (10 < x && x<20) { #middle column
    if (20 < y && y<30) { #top bar
      selected <- 2
    }
    else if (10 < y && y<20) { #middle bar
      selected <- 5
    } 
    else { #bottom bar
      selected <- 8
    }}
  
  else { #right column
    if (20 < y && y<30) { #top bar
      selected <- 3
    }
    else if (10 < y && y<20) { #middle bar
      selected <- 6
    } 
    else { #bottom bar
      selected <- 9
    }}
  
  return(selected)
}
