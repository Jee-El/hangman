# frozen_string_literal: true

require_relative './platform_name'
require_relative './display'
require_relative './computer_game_setup'
require_relative './phone_game_setup'
require_relative './game'

def play
  Hangman::Display.welcome
  case Hangman::PlatformName.get
  when 'phone' then game_setup = Hangman::PhoneGameSetup.new
  when 'computer' then game_setup = Hangman::ComputerGameSetup.new
  end

  game_setup.run

  players = game_setup.settings[:players]
  word_length = game_setup.settings[:word_length]

  game = Hangman::Game.new(*players, word_length)
  game.start
end

play
