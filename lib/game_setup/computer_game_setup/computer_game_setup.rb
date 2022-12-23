# frozen_string_literal: true

require 'tty-prompt'

require_relative '../game_setup'
require_relative '../../displayable/computer_displayable/computer_displayable'

module Hangman
  # Setup for computer users
  # It uses some tty-prompt features which can't be used on phone
  # (e.g: replit on phone)
  class ComputerGameSetup < GameSetup
    include ComputerDisplayable

    SAVED_GAMES = YAML.safe_load_file(
      'saved_games.yaml',
      permitted_classes: [Board, Game, HumanPlayer, ComputerPlayer, Symbol, Time]
    )

    def self.saved_game_to_load
      saved_games = SAVED_GAMES.map.with_index(1) do |saved_game, i|
        "#{i}. #{saved_game[:name]} -> #{saved_game[:timestamp]}"
      end
      saved_game = TTY::Prompt.new.select('Choose a game :', saved_games)
      saved_game_index = saved_game[0].to_i
      saved_game_index -= 1
      SAVED_GAMES[saved_game_index]
    end

    def human_player_role
      puts
      roles_to_nums = { 'Word Guesser' => '1', 'Word Picker' => '2' }
      role = TTY::Prompt.new.select('Choose your role :', ['Word Guesser', 'Word Picker'])
      roles_to_nums[role]
    end

    def word_length
      puts
      TTY::Prompt.new.slider('Word Length : ', 2..16)
    end

    def max_guesses
      puts
      TTY::Prompt.new.slider('Maximum number of guesses : ', (1..26))
    end
  end
end
