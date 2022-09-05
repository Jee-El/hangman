require 'colorize'

module Hangman
  # Draws the underscores & letters
  class Board
    def initialize(word_length)
      @slots = Array.new(word_length) { '_' }
    end

    def slots
      @slots.join(' ')
    end

    def update(guess, word)
      if word.include?(guess)
        word.length.times { |i| @slots[i] = guess.green if word[i] == guess }
      end
      puts(@slots.join(' ')) || puts
    end
  end
end
