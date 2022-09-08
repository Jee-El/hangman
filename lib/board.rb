require 'colorize'

module Hangman
  # Draws the underscores & letters
  class Board
    def initialize(word_length)
      @slots = Array.new(word_length) { '_' }
      @wrong_guesses = []
    end

    def slots
      @slots.join(' ')
    end

    def update(guess, word)
      if word.include?(guess)
        word.length.times { |i| @slots[i] = guess.green if word[i] == guess }
      else
        @wrong_guesses.push(guess.red)
      end
      print(@slots.join(' ')) || print(' | ') || print(@wrong_guesses.join(' '))
      puts
    end
  end
end
