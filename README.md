This package will run simulations of several popular games and give information about what happens when a user plays the game. These are the games available in this package:

1. Black Jack: In this game, two players are initially given two cards, and they do not know the other person’s cards. The goal of the game is to either have the sum of the cards equal 21 or, if the game ends, get a higher sum than the other player. However, if the sum of the cards is higher than 21, then the player loses. Cards are worth their numeric value (and Jack is worth 11, Queen 12, King 13, and Ace can be 1 or 11 depending on what the player decides). The player can either draw more cards or stop drawing cards, but they will not know what card they draw before they actually draw the card. The game ends when both players decide to stop drawing. The game ties if both players end up with a sum of at least 21 or if both players end up with the same sum.   

2. Boggle  

3. Chinese Poker  

4. Tic Tac Toe  


There are four things this package gives.  

1. The user can play any of the games available.  
+ Black Jack: The user plays against a computer. They are given two card values initially and then are asked if they would like to keep on drawing.    
+ Boggle   
+	Chinese Poker  
+	Tic Tac Toe  

2. The user can get a suggestion of a good move for their current place in the game.
+ Black Jack: The user is told whether they should draw or not. This will be based on previous heuristics of what is the most optimal move or something different (like the probability of winning if they do decide to draw compared to the probability of staying). If the user initially has an Ace, they are told also if it is better to treat the Ace as a 1 or an 11. 
+ Boggle   
+	Chinese Poker  
+	Tic Tac Toe  

3. The user can see what happens in the game over time on average with their initial placement.
+ Black Jack: The user gets to see a graph of the probability of winning by the number of draws, given their initial placement. 
+ Boggle   
+	Chinese Poker  
+	Tic Tac Toe  

4. The user can see how they are doing compared to the average. 
+ Black Jack (where ace is 1 or 11): The user can see how well they played based on the probability of them winning the number of games they won with the initial cards they had. 
+ Boggle   
+	Chinese Poker  
+	Tic Tac Toe  
