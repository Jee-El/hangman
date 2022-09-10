# Hangman

## Play it here

- Login not required :

  [Replit](https://replit.com/@Jee-El/Hangman?v=1)

- Login required :

  [![Run on Repl.it](https://replit.com/badge/github/Jee-El/hangman)](https://replit.com/new/github/Jee-El/hangman)

## About

From [Wikipedia](<https://en.wikipedia.org/wiki/Hangman_(game)>) :

> Hangman is a guessing game for two or more players. One player thinks of a word, phrase or sentence and the other(s) tries to guess it by suggesting letters within a certain number of guesses.

Although, in this project, one player can only choose a word from a list of words.

## Main Feature

### Option to save a game & load it later

Typing `:w` at any point, starting from when the guessing starts, will save a copy of the game to a `yaml` file. The next time you play the game, it'll prompt you to choose whether to load a saved game or start a new one.

This was the main concept I practiced with this project.

## Other features

### Can Play As Word Picker & Word Guesser

Option to play either as :

- Word picker :

  You pick a word from a list of words, then the computer tries to guess it by following this simple strategy :

  - Start with the most commonly occuring letters : e-t-a-o-i-n-s-h-r-d-l-u, from left to right (most to least).

  - Pick a letter randomly from the left possible letters.

- Word Guesser :

  The computer will pick a word from the same list, then you have to guess it.

### Choose The Word's Length & Maximum Amount Of Guesses To Make

On the computer, you get a slider that allows you to choose a numerical value by using left/right arrow keys.

On a phone, you enter the numerical value.
