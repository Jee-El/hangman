# frozen_string_literal: true

require 'tty-prompt'

require_relative './display'
require_relative './player'

module Hangman
  class HumanPlayer < Player
    include Display

    def initialize(name)
      super
      @guesses = []
    end

    def guess
      2.times { puts }
      guess = TTY::Prompt.new.ask('Enter your guess : ') { |q| q.modify :remove, :down }

      return guess if guess.nil?

      return already_guessed(guess) if already_guessed?(guess)

      return not_a_letter(guess) if not_a_letter?(guess)

      @guesses.push(guess) && guess
    end

    def secret_word(words)
      show_how_to_change_list
      loop do
        print_words_list(words)
        word = gets.chomp
        Display.clear
        break word if valid_word?(word, words)

        next words.rotate!(6) if word.empty?

        invalid_word
      end
    end

    private

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
