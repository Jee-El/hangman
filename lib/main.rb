# frozen_string_literal: true

require 'yaml'

require_relative './platform_name'
require_relative './display'
require_relative './computer_game_setup'
require_relative './phone_game_setup'
require_relative './game'

def play
  Hangman::Display.welcome
  x = resume?
  x ? resume_game(x) : new_game
end

def resume?
  saved_games = YAML.safe_load(
    File.read('saved_games.yaml'),
    permitted_classes: [Hangman::Board, Hangman::Game, Hangman::HumanPlayer, Hangman::ComputerPlayer, Symbol]
  ) || {}
  return if saved_games.empty?

  puts 'Do you wanna start a new game, or resume?'
  puts "1 => resume\n\n2 => new game\n"
  answer = gets.chomp.downcase
  return saved_games[:saved_game_1] if answer == '1'
end

def resume_game(game)
  game.start
end

def new_game
  game_setup.run
  players = game_setup.settings[:players]

  words = File.foreach('dictionary.txt').map(&:chomp).filter do |word|
    word.length == game_setup.settings[:word_length]
  end

  game = Hangman::Game.new(*players, words)
  game.start
end

def game_setup
  case Hangman::PlatformName.get
  when 'phone' then Hangman::PhoneGameSetup.new
  when 'computer' then Hangman::ComputerGameSetup.new
  end
end

play
