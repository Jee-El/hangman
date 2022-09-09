require 'colorize'

module Hangman
  # Draws the underscores & letters
  class Board
    def initialize(word_length)
      @slots = Array.new(word_length) { '_' }
      @wrong_guesses = []
      @guesses_count = 0
    end

    def slots
      @slots.join(' ')
    end

    def wrong_guesses
      @wrong_guesses.join(' ')
    end

    def update(guess, word)
      @guesses_count += 1
      if word.include?(guess)
        word.length.times { |i| @slots[i] = guess.green if word[i] == guess }
      else
        @wrong_guesses.push(guess.red)
      end
      [slots, wrong_guesses].each { |elem| print(elem) || print(' | ') }
      print @guesses_count || puts
    end
  end
end
