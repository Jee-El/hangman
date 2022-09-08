# frozen_string_literal: true

require_relative './player'

module Hangman
  # The computer picks a word randomly
  # The computer guesses based on the most common letters
  class ComputerPlayer < Player
    def initialize(name)
      super
      alphabet = *'a'..'z'
      @guesses_to_make = %w[e t a o i n s h r d l u]
      @guesses_to_make += (alphabet - @guesses_to_make)
    end

    def guess
      sleep 1.1
      puts
      guess = if @guesses_to_make.length > 14
                @guesses_to_make.shift
              else
                @guesses_to_make.sample
              end
      puts || guess
    end

    def secret_word(words)
      words.sample
    end
  end
end
