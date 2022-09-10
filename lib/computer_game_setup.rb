# frozen_string_literal: true

require 'tty-prompt'

require_relative './game_setup'
require_relative './computer_display'

module Hangman
  # Setup for computer users
  # It uses some tty-prompt features which can't be used on phone
  # (e.g: replit on phone)
  class ComputerGameSetup < GameSetup
    include ComputerDisplay

    SAVED_GAMES = YAML.safe_load(
      File.read('saved_games.yaml'),
      permitted_classes: [Board, Game, HumanPlayer, ComputerPlayer, Symbol, Time]
    ) || {}

    def self.saved_game_to_load
      saved_games = SAVED_GAMES.map { |key, value| "#{key} -> #{value[:timestamp]}" }
      saved_game = TTY::Prompt.new.select('Choose a game :', saved_games, convert: :symbol)
      SAVED_GAMES[saved_game]
    end

    def human_player_role
      puts
      roles_to_nums = { 'Word Guesser' => '1', 'Word Picker' => '2' }
      role = TTY::Prompt.new.select('Choose your role :', ['Word Guesser', 'Word Picker'])
      Display.clear
      roles_to_nums[role]
    end

    def word_length
      puts
      word_length = TTY::Prompt.new.slider('Word Length : ', 1..18)
      Display.clear
      word_length
    end

    def max_guesses
      puts
      max_guesses = TTY::Prompt.new.slider('Maximum number of guesses : ', (1..26))
      Display.clear
      max_guesses
    end
  end
end
