# frozen_string_literal: true

class Player
  attr_reader :name, :made_guesses
  attr_accessor :guesses_count

  def initialize(name)
    @name = name
    @made_guesses = []
    @guesses_count = 0
  end
end
