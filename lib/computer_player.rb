# frozen_string_literal: true

require_relative './player'

class ComputerPlayer < Player
  def initialize(name)
    super
    alphabet = *'a'..'z'
    @guesses_to_make = %w[e t a o i n s h r d l u]
    @guesses_to_make += (alphabet - @guesses_to_make)
  end

  def guess
    sleep 1.1
    return @guesses_to_make.shift if @guesses_to_make.length > 14

    @guesses_to_make.sample
  end

  def secret_word(words)
    words.sample
  end
end
