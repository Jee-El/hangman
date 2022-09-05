# frozen_string_literal: true

require_relative './display'
require_relative './validation_regexes'
require_relative './player'

module Hangman
  class HumanPlayer < Player
    include ValidationRegexes
    include Display

    def guess
      loop do
        guess = gets.chomp
        break made_guesses.push(guess) if valid_guess?(guess)

        break if guess == ':w'

        puts "Guess : #{guess}" || invalid_guess(guess)
      end
      puts("Guess : #{guess}") || guess
    end

    def valid_guess?(guess)
      guess.gsub(' ', '').match?(VALID_GUESS[:regex]) && !made_guesses.include?(guess)
    end

    def invalid_guess(guess)
      return puts VALID_GUESS[:error] unless made_guesses.include?(guess)

      already_guessed
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

    def invalid_word
      puts 'Not a valid word'
    end
  end
end
