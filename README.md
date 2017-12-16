## **FINAL SUBMISSION: strategygames.zip file (inc. vignette) in strategygames folder**

Our package will consist of 4 games: Black Jack, Boggle, Chinese Poker and Tic Tac Toe. The use will be able to play these games with the computer. 

**1. Black Jack (Anna)** 
In this game, two players are initially given two cards, and they do not know the other person’s cards. The goal of the game is to either have the sum of the cards equal 21 or, if the game ends, get a higher sum than the other player. However, if the sum of the cards is higher than 21, then the player loses. Cards are worth their numeric value (and Jack is worth 11, Queen 12, King 13, and Ace can be 1 or 11 depending on what the player decides). The player can either draw more cards or stop drawing cards, but they will not know what card they draw before they actually draw the card. The game ends when both players decide to stop drawing. The game ties if both players end up with a sum of at least 21 or if both players end up with the same sum.   

**2. Boggle (Brian)** 
Sixteen letters are randomly placed in a square formation. The player must come up with words that can be made by connecting adjacent letters. 

**3. Chinese Poker (Linde)**
This game will be played with 3 people (54/3 = 18 cards per player). The goal of the game is to be the first to get rid of all the cards in your hands. Most cards are worth their numeric value (Jack 11, Queen 12, King 13). Except A, 2 and Jokers, which are ranked above King. The player with 3 of Hearts starts the game. Players can put down cards that are worth more than the last play on the table. Players can put down a single card, a pair, a full house or four of a kind (bomb). Any pair is greater than any single card, any full house is greater than any pair, and any bomb is greater than any full house. If a player is unable to make a move, he/she can pass.   

**4. Tic Tac Toe (Olivia)**  
The object of Tic Tac Toe is to get three X's or O's in a row. You play on a three by three game board. Players alternate placing Xs and Os on the game board until either opponent has three in a row (a win for that opponent) or all nine squares are filled (a tie).

**The user can play any of the games available.**  
+ Black Jack: The user plays against a computer. They are given two card values initially and then are asked if they would like to keep on drawing.    
+ Boggle: The program will randomly create a formation of sixteen letters and check the validity of the user's entered words by first solving for all possible words checking against a built-in dictionary. (This may be limited to a certain length and a certain number of common English words.)
+	Chinese Poker: User plays against a computer. 
+	Tic Tac Toe: User plays against a computer. The user starts first, and the computer uses a Minimax algorithm to defend itself. The board will be represented either as (a) a 3x3 matrix that simply prints to the console, and requires users to enter the "coordinates" of where they want to place their X/O, or (b) a graphical representation using the plot command, which allows the user to click where they want to place their X/O using R's locator() function.
