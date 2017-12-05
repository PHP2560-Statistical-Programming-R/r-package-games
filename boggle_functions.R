#valid words 3-6 letter words that appear on list of 10000
#most common words in English

#some words are not words in the traditional sense,
#for instance "lol"

#Letter spaces on board may be used multiple times
#as long as they are not consecutive

#use lower-case

load('dict.Rdata')

#create a random 4x4 grid of letters according
#to approximate frequencies in English
boggle_makeBoard = function(){
  probs = .01*c(12.02,9.1,8.12,7.68,7.31,6.95,
                6.28,6.02,5.92,4.32,3.98,2.88,
                2.71,2.61,2.30,2.11,2.09,2.03,
                1.82,1.49,1.11,.69,.17,.11,
                .10,.07)
  letters = c('e','t','a','o','i','n','s','r',
              'h','d','l','u','c','m','f','y',
              'w','g','p','b','v','k','x','q',
              'j','z')
  board = matrix(sample(letters, 16,probs,replace=T),
                 nrow=4, ncol=4)
  return(board)
}

#return adjacent spaces of coordinate (c1,c2)
#hard-coded
boggle_getAdjacent = function(c1, c2){
  adj = rbind(c(c1,c2+1),c(c1,c2-1),c(c1+1,c2),c(c1-1,c2),c(c1+1,c2+1),c(c1-1,c2+1),
              c(c1-1,c2-1),c(c1+1,c2-1))
  adj = subset(adj, adj[,1] %in% 1:4 & adj[,2] %in% 1:4)
  return(adj)
}

#check whether word is valid on board
boggle_checkWord = function(word, board=boggle_makeBoard()){
  if(!is.character(word) | !length(word)==1){
    message("Please enter a string")
    return(FALSE)
  }
  word_letters = unlist(strsplit(word, ""))
  if(!(length(word_letters) %in% 3:6)){
    message("Word must be between 3 and 6 letters long")
    return(FALSE)
  }
  if (!word %in% dict){
    message("Word not recognized in dictionary")
    return(FALSE)
  }
  for(i in 1:4){
    for(j in 1:4){
        if(boggle_checkWordSpec(word_letters, board, i, j, 1)){
          message("Word is valid")
          return(TRUE)
        }
    }
  }
  message("Word cannot be made on board")
  return(FALSE)
}

#recursive helper function to check if word is possible 
#from a specified starting coordinate
boggle_checkWordSpec = function(word_letters, board, i, j, place){
  if (place-1 == length(word_letters)){
    return(TRUE)
  }
  if(board[i,j] != word_letters[place]){
    return(FALSE)
  }
  else {
    adj = boggle_getAdjacent(i,j)
    good = vector("logical", length=dim(adj)[1])
    for(k in 1:length(good)){
      good[k] = boggle_checkWordSpec(word_letters, board, adj[k,1],adj[k,2],place+1)
    }
    return(any(good))
  }
}

boggle_play=function(board=boggle_makeBoard()){
  score = 0
  valid.words = NULL
  while(1){
    print(board)
    try.word = readline(prompt="Enter a word! \n Or enter QUIT to quit or GIVE UP to display words")
    if(try.word =="QUIT"){
      return("Goodbye!")
    } else if(try.word == "GIVE UP"){
      return(boggle_find_words(board))
    } else if (try.word %in% valid.words){
      message("You already played that word!")
      next
    }
    valid = boggle_checkWord(try.word, board)
    if(valid){
      score = score+1
      valid.words = c(valid.words, try.word)
      if(score==1){
        message("You found a word!")
      } else{
      message(paste("You've found "), score, (" words!"))
      }
    }
  }
}

boggle_find_words = function(board=boggle_makeBoard){
  valid.words = NULL
  for(i in 1:length(dict)){
    if(suppressMessages(boggle_checkWord(dict[i]))){
      valid.words = c(valid.words, dict[i])
    }
  }
  return(valid.words)
}