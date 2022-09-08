# frozen_string_literal: true

require_relative './display'
require_relative './validation_regexes'
require_relative './player'

module Hangman
  class HumanPlayer < Player
    include ValidationRegexes
    include Display

    def initialize(name)
      super
      @guesses = []
    end

    def guess
      loop do
        puts
        guess = gets.chomp
        puts
        break @guesses.push(guess) && guess if valid_guess?(guess)

        break guess if guess == ':w'

        invalid_guess(guess)
      end
    end

    def valid_guess?(guess)
      guess.gsub(' ', '').match?(VALID_GUESS[:regex]) && !@guesses.include?(guess)
    end

    def invalid_guess(guess)
      return puts VALID_GUESS[:error] unless @guesses.include?(guess)

      already_guessed(guess)
    end

    def secret_word(words)
      show_how_to_change_list
      loop do
        print_words_list(words)
        word = gets.chomp
        clear_screen
        break word if valid_word?(word, words)

        next words.rotate!(6) if word.empty?

        invalid_word
      end
    end

    def valid_word?(word, words)
      words.include?(word) || word == ':w'
    end
  end
end
