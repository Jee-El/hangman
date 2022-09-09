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
      saved_game = TTY::Prompt.new.select('Choose a game :', SAVED_GAMES.keys[1..])
      SAVED_GAMES[saved_game.to_sym]
    end

    def human_player_role
      puts
      roles_to_nums = { 'Word Guesser' => '1', 'Word Picker' => '2' }
      role = @prompt.select('Choose your role :', ['Word Guesser', 'Word Picker'])
      Display.clear
      roles_to_nums[role]
    end

    def word_length
      puts
      word_length = @prompt.slider('Word Length : ', 1..18)
      Display.clear
      word_length
    end

    def max_guesses
      puts
      max_guesses = @prompt.slider('Maximum number of guesses : ', (1..36))
      Display.clear
      max_guesses
    end
  end
end
