# frozen_string_literal: true

require 'yaml'

require_relative './platform_name'
require_relative './display'
require_relative './computer_game_setup'
require_relative './phone_game_setup'
require_relative './game'

def play
  Hangman::Display.welcome

  platform_name = Hangman::Display::PlatformName.get

  Hangman::Display.clear

  return Hangman::Game.load(platform_name) if Hangman::Game.resume?

  new_game(platform_name)
end

def new_game(platform_name)
  game_setup = get_game_setup(platform_name)
  game_setup.run

  players = game_setup.settings[:players]
  words = File.foreach('dictionary.txt').map(&:chomp).filter do |word|
    word.length == game_setup.settings[:word_length]
  end

  game = Hangman::Game.new(*players, words)
  game.start
end

def get_game_setup(platform_name)
  case platform_name
  when 'phone' then Hangman::PhoneGameSetup.new
  when 'computer' then Hangman::ComputerGameSetup.new
  end
end

play
