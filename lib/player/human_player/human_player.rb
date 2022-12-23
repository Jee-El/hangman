# frozen_string_literal: true

require 'tty-prompt'

require_relative '../../displayable/displayable'
require_relative '../player'

module Hangman
  class HumanPlayer < Player
    include Displayable

    def initialize(name)
      super
      @guesses = []
    end

    def guess
      2.times { puts }
      guess = TTY::Prompt.new.ask('Enter your guess : ') { |q| q.modify :remove, :down }

      return no_input if no_input?(guess)

      return already_guessed(guess) if already_guessed?(guess)

      return not_a_letter(guess) if not_a_letter?(guess)

      @guesses.push(guess) unless guess == ':w'

      guess
    end

    def secret_word(words)
      show_how_to_change_list
      loop do
        print_words_list(words)
        word = gets.chomp
        Displayable.clear
        break word if valid_word?(word, words)

        next words.rotate!(6) if word.empty?

        invalid_word
      end
    end

    private

    def no_input?(guess)
      guess.nil?
    end

    def not_a_letter?(guess)
      !guess.match?(/^[a-z]{1}$/i) && guess != ':w'
    end

    def already_guessed?(guess)
      @guesses.include?(guess)
    end

    def valid_word?(word, words)
      words.include?(word) || word == ':w'
    end
  end
end
