# General 

- very interesting 
- not many games in R so bound to be a huge hit. 

# challenges 

- the logic with card games is always tricky.
- remember you have to deal with replacement or no replacement with card selections. 
- for boggle be mindful of needing a good dictionary for R to fund words with. 



## Feedback 12-13-2017

### Blackjack

- The game works really well and even gives error messages. 
- When the person draws an Ace it tells them to pick a value, you may want to give them options of values to give. 
- Instead of using card numbers name the numbers for the face cards so that the player sees that instead. 

### Boggle

- you will want to check if this is actually finding words correctly For example:

I got this board

```
     [,1] [,2] [,3] [,4]
[1,] "e"  "e"  "c"  "o" 
[2,] "n"  "h"  "e"  "l" 
[3,] "l"  "h"  "i"  "e" 
[4,] "r"  "s"  "b"  "r"
```

This led to these words: 

```
Enter a word! 
 Or enter QUIT to quit or GIVE UP to display wordsGIVE UP
 [1] "has"    "some"   "name"   "set"    "did"    "three"  "non"    "teen"   "test"  
[10] "users"  "act"    "sure"   "ago"    "none"   "huge"   "sat"    "bed"    "est"   
[19] "father" "piece"  "met"    "wait"   "inch"   "refer"  "hip"    "eric"   "iran"  
[28] "outlet" "res"    "qty"    "dad"    "tie"    "nyc"    "aaa"    "gains"  "ist"   
[37] "das"    "mem"    "stat"   "detect" "phi"    "acer"   "polo"   "rna"    "suse"  
[46] "pts"    "dod"    "tier"   "tar"    "tent"   "irs"    "dude"   "leone"  "dana"  
[55] "ant"    "gig"    "ate"    "casa"   "ata"    "tooth"  "mia"   
```

for a quick glance there is no "d" 


## Chinese poker

The game doesnt load dplyr by itself
I am not quite sure how to play the game so  I cannot offer much for it other than maybe give some examples of game play for this. 

## Tic Tac Toe

- the game works well
- I like the use of the click squares
- It felt good to beat the computer a few times !