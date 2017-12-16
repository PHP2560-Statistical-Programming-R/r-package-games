---
title: "Introduction to Strategy Games"
author: "Brian Gilbert, Linde Chen, Olivia Iles, Anna Xu"
output: rmarkdown::html_vignette
vignette: >
  %\VignetteIndexEntry{Introduction to strategygames}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}
---
The strategygames packages introduces 4 simple strategy games to users of R:

+ Chinese Poker
+ Boggle
+ Tic Tac Toe
+ Black Jack 

This document introduces you to strategygame's basic functions and how to use them in the games.

## **Chinese Poker**

chinese.poker() allows the user to begin playing a game of Chinese Poker with two computer opponents in the console. Once this function is run and the game begins, the user will be dealt a hand of 18 cards. By default, the user makes the first move.

**Rules of the Game**

+ First player to get rid of his/her cards wins. 
+ You can play a card if it is **better** than your previous opponent's.
+ **Enter single cards in console normally, without quotations.** 
+ **Enter special hands in console separated by commas but no space: 5,5 or J,J**

**Ranking of Cards**

+ All suits are worth the same value.
+ All single card values are displayed when user plays the game.
+ The ranking of single cards: 2-10, J, Q, K, A, Little Joker, Big Joker.
+ The ranking of special hands: single, pair, triple, bomb (four of a kind).

**For instance**: If your opponent plays a single 5, you can play any single card greater than 5 in ranking, **OR** or can play a special hand greater than a single in ranking - e.g. a pair of 3's.

These 18 cards will be automatically sorted for the user for ease of viewing. At each turn, the user will be prompted as to whether or not he/she would like to check his/her current hand. 

**Example Game** 
Let's say you are dealt this hand. 
```
$`1`
# A tibble: 5 x 3
# Groups:   rank [5]
       rank value  freq
      <chr> <chr> <int>
1         2     2     1
2         7     7     1
3         9     9     1
4 Big Joker    30     1
5         K    13     1

$`2`
# A tibble: 5 x 3
# Groups:   rank [5]
   rank value  freq
  <chr> <chr> <int>
1    10    10     2
2     3     3     2
3     5     5     2
4     8     8     2
5     Q    12     2

$`3`
# A tibble: 1 x 3
# Groups:   rank [1]
   rank value  freq
  <chr> <chr> <int>
1     4     4     3
```

You'll want to get rid of your smallest cards first. Say you play a single 2. 

```
[1] 7
[1] "new round"
[1] 9
```

Opponent 1 plays a 7 and Opponent 2 plays a 9 - both single cards greater than 2. You're prompted to answer whether or not you'd like to check your current hand. 

```
$`1`
# A tibble: 4 x 3
# Groups:   rank [4]
       rank value  freq
      <chr> <chr> <int>
1         7     7     1
2         9     9     1
3 Big Joker    30     1
4         K    13     1

$`2`
# A tibble: 5 x 3
# Groups:   rank [5]
   rank value  freq
  <chr> <chr> <int>
1    10    10     2
2     3     3     2
3     5     5     2
4     8     8     2
5     Q    12     2

$`3`
# A tibble: 1 x 3
# Groups:   rank [1]
   rank value  freq
  <chr> <chr> <int>
1     4     4     3
```

Notice that the single 2 card is disposed of after being played. Say now you'd like to play a pair of 5's. 

```
[1] 13 13
[1] "new round"
[1] 14 14
```

Your opponents return a pair of K's and a pair of A's. The pair of 5's will be disposed of from your current hand. 

```
$`1`
# A tibble: 4 x 3
# Groups:   rank [4]
       rank value  freq
      <chr> <chr> <int>
1         7     7     1
2         9     9     1
3 Big Joker    30     1
4         K    13     1

$`2`
# A tibble: 4 x 3
# Groups:   rank [4]
   rank value  freq
  <chr> <chr> <int>
1    10    10     2
2     3     3     2
3     8     8     2
4     Q    12     2

$`3`
# A tibble: 1 x 3
# Groups:   rank [1]
   rank value  freq
  <chr> <chr> <int>
1     4     4     3
```
Keep playing until you get rid of all your cards!

**Note the limitations of this game.** 
For simplicity: 
1. Traditionally, can be played with 3-5 people. Here, we are only allowing for three. 
2. The hands fullhouse and straight flush are not included in this computer game.

## **Boggle**

Calling boggle_play allows the user to play an adapted version of Boggle. The user must enter words that are able to be made by combining adjacent letters on the board. The program keeps track of the words entered, and it can display all possible words if requested. The program gives instructions for its use. The game differs from standard boggle in the following ways. First, the same letter square may be used twice in the same word, as long as it is not used consecutively. Also, the Boggle program uses a considerably reduced dictionary. The list of word comes from the list of 10000 most common English words as compiled in the following GitHub repo: https://github.com/first20hours/google-10000-english. This list was further cut down by considering only words of 3-6 letters. This list was compiled from Google data, so it contains some words that are not Standard English (such as "lol"), and it does not contain many words that are familiar to the average user yet fall outside the top 10000 common words.

## **Tic Tac Toe**

Calling the function ticTacToe() lets users play a game of Tic Tac Toe against the computer. The gameboard is displayed in the R plot window, and users click on board squares to make their move. The game ends when one player gets three of their pieces in a row, or no more moves can be made (a draw). The clearBoard() function can be called after a game to reset the board.

## **Black Jack**

blackjack() allows you to play Black Jack in the R command window using the most barebone representations of playing cards (e.g., using only value of cards rather than the cards themselves). 

The user first indicates whether they want a hand or if they want to input their own hand. Since Black Jack only depends on the value of each card, the user will just receive the values of their card (2-10, where 10 can be either from the card 10, King, or Queen). **note: since all Face Cards are considered value 10, if the user has a Face Card, this will be represented as 10 in the hand**

If the user receives an Ace, this will be indicated by the card 13, and they will be asked to then set a binding value for Ace. They are then asked if they'd like to continue drawing. Users will be shown their hand (which notes whether they have an Ace or not) as well as the values of their hand. 

When they stop drawing, it will then be player 2's (i.e., the computer/dealer) turn. Once the game ends, they are shown the sum of both players. They can then replay. Once they decide to no longer replay, the user will be shown their score and the computer's score. 
