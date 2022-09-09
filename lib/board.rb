require 'colorize'

module Hangman
  # Draws the underscores & letters
  class Board
    attr_accessor :left_guesses

    def initialize(word_length, max_guesses)
      @slots = Array.new(word_length) { '_' }
      @wrong_guesses = []
      @left_guesses = max_guesses
    end

    def slots
      @slots.join(' ')
    end

    def wrong_guesses
      @wrong_guesses.join(' ')
    end

    def draw(guess, word)
      update(guess, word) unless guess.nil? || guess.length > 1 || guess == ':w'

      [slots, wrong_guesses].each { |elem| print(elem) || print(' | ') }
      print(@left_guesses) || 2.times { puts }

      # Invalid guess message
      print guess if guess.length > 1
    end

    def update(guess, word)
      if word.include?(guess)
        word.length.times { |i| @slots[i] = guess.green if word[i] == guess }
      else
        @wrong_guesses.push(guess.red)
        @left_guesses -= 1
      end
    end
  end
end
