# frozen_string_literal: true

module Hangman
  class Player
    attr_reader :name
    attr_accessor :guesses_count

    def initialize(name)
      @name = name
      @guesses_count = 0
    end
  end
end
