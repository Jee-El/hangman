# frozen_string_literal: true

module Hangman
  class Player
    attr_reader :name

    def initialize(name)
      @name = name
    end
  end
end
