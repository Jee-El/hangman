# frozen_string_literal: true

require 'yaml'

require_relative 'platform_name'
require_relative 'displayable/displayable'
require_relative 'game_setup/computer_game_setup/computer_game_setup'
require_relative 'game_setup/phone_game_setup/phone_game_setup'
require_relative 'game/game'

def play
  Hangman::Displayable.welcome

  platform_name = Hangman::Displayable::PlatformName.answer

  Hangman::Displayable.clear

  return Hangman::Game.load(platform_name) if Hangman::Game.resume?

  new_game(platform_name).start
end

def new_game(platform_name)
  game_setup(platform_name).run do |settings|
    players = settings[:players]
    words = settings[:words]
    max_guesses = settings[:max_guesses]
    Hangman::Game.new(*players, words, max_guesses)
  end
end

def game_setup(platform_name)
  case platform_name
  when 'phone' then Hangman::PhoneGameSetup.new
  when 'computer' then Hangman::ComputerGameSetup.new
  end
end

play
