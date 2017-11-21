This package will run simulations of several popular games and give information about what happens when a user plays the game. These are the games available in this package:

**1. Black Jack (Anna)** 
In this game, two players are initially given two cards, and they do not know the other person’s cards. The goal of the game is to either have the sum of the cards equal 21 or, if the game ends, get a higher sum than the other player. However, if the sum of the cards is higher than 21, then the player loses. Cards are worth their numeric value (and Jack is worth 11, Queen 12, King 13, and Ace can be 1 or 11 depending on what the player decides). The player can either draw more cards or stop drawing cards, but they will not know what card they draw before they actually draw the card. The game ends when both players decide to stop drawing. The game ties if both players end up with a sum of at least 21 or if both players end up with the same sum.   

**2. Boggle (Brian)** 
Sixteen letters are randomly placed in a square formation. The player must come up with words that can be made by connecting adjacent letters. 

**3. Chinese Poker (Linde)**
This game can be played with 3-5 people. The goal of the game is to be the first to get rid of all the cards in your hands. Most cards are worth their numeric value (Jack 11, Queen 12, King 13). Except A, 2 and Jokers, which are ranked above King. The player with 3 of Hearts starts the game. Players can put down cards that are worth more than the last play on the table. Players can put down a single card, a pair, a full house or four of a kind (bomb). Any pair is greater than any single card, any full house is greater than any pair, and any bomb is greater than any full house. If a player is unable to make a move, he/she can pass.   

**4. Tic Tac Toe (Olivia)**  
The object of Tic Tac Toe is to get three X's or O's in a row. You play on a three by three game board. Players alternate placing Xs and Os on the game board until either opponent has three in a row (a win for that opponent) or all nine squares are filled (a tie).


There are four things this package gives.  

**1. The user can play any of the games available.**  
+ Black Jack: The user plays against a computer. They are given two card values initially and then are asked if they would like to keep on drawing.    
+ Boggle: The program will randomly create a formation of sixteen letters and check the validity of the user's entered words by first solving for all possible words checking against a built-in dictionary. (This may be limited to a certain length and a certain number of common English words.)
+	Chinese Poker: User plays against a computer. 
+	Tic Tac Toe: User plays against a computer. The user starts first, and the computer uses a Minimax algorithm to defend itself. The board will be represented either as (a) a 3x3 matrix that simply prints to the console, and requires users to enter the "coordinates" of where they want to place their X/O, or (b) a graphical representation using the plot command, which allows the user to click where they want to place their X/O using R's locator() function.

**2. The user can get a suggestion of a good move for their current place in the game.**
+ Black Jack: The user is told whether they should draw or not. This will be based on previous heuristics of what is the most optimal move or something different (like the probability of winning if they do decide to draw compared to the probability of staying). If the user initially has an Ace, they are told also if it is better to treat the Ace as a 1 or an 11. 
+ Boggle: The computer will display all possible words on a given board.
+	Chinese Poker: The user is told which card to play next, or if he/she should pass.    
+	Tic Tac Toe: The user is told what square the AI would choose in their shoes (based on Minimax).

**3. The user can see what happens in the game over time on average with their initial placement.**
+ Black Jack: The user gets to see a graph of the probability of winning by the number of draws, given their initial placement. 
+ Boggle: The user is told how many words are possible, possibly broken down by length.
+	Chinese Poker: User can see the probability of a particular player winning with his/her hand.  
+	Tic Tac Toe: The user can see the probability of winning/losing/tie-ing based on their first move, assuming all future moves are random (for the sake of simplicity & to focus on only that first move) against an AI that uses Minimax. This will be calculated by running n simulated games for each first move, in which the "user" moves are random (with the exception of the first), and the AI defends using Minimax. All outcomes will be recorded, and the percentages of wins/ties/losses will be calculated. This will be displayed as a board with the percentages for each initial move displayed in the corresponding board square.

**4. The user can see how they are doing compared to the average.** 
+ Black Jack (where ace is 1 or 11): The user can see how well they played based on the probability of them winning the number of games they won with the initial cards they had. 
+ Boggle: Given a position and a user's reported results, the program tells the user what percentage of words they successfully found, possibly broken down by length.
+	Chinese Poker: The user can see how well they played based on the probability of them winning the number of games they won with the initial cards they had.   
+	Tic Tac Toe: The user can see what percentage of games they have won/lost/tied compared to what percentage a player using random choice would win/lose/tie. (This would probably be aggregated over all possible initial moves based on the percentages calculated in **3**).
