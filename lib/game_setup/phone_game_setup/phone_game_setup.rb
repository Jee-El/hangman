# frozen_string_literal: true

require 'tty-box'

require_relative '../game_setup'
require_relative '../../displayable/phone_displayable/phone_displayable'

module Hangman
  # Setup for phone users
  # It doesn't use some tty-prompt features that can't be used on phone
  # (e.g: replit on phone)
  class PhoneGameSetup < GameSetup
    include PhoneDisplayable

    SAVED_GAMES = YAML.safe_load_file(
      'saved_games.yaml',
      permitted_classes: [Board, Game, HumanPlayer, ComputerPlayer, Symbol, Time]
    )

    def self.saved_game_to_load
      list_saved_games
      loop do
        index = gets.to_i

        if SAVED_GAMES[index]
          Displayable.clear
          break SAVED_GAMES[index]
        end

        invalid_index
      end
    end

    def self.list_saved_games
      saved_games = SAVED_GAMES.map.with_index(1) do |saved_game, i|
        "#{i}. #{saved_game[:name]} -> #{saved_game[:timestamp]}\n\n"
      end
      puts TTY::Box.frame(saved_games, padding: [1, 1], title: { top_center: ' Choose a game : ' })
    end

    def human_player_role
      puts
      ask_for_human_player_role
      loop do
        print 'Enter either the number 1 or 2 : '
        role = gets.chomp
        puts
        break Displayable.clear || role if valid_role?(role)
      end
    end

    def word_length
      puts
      TTY::Prompt.new.ask(
        'Enter the secret word\'s length',
        default: 7,
        convert: :int
      ) { |q| q.in('2-16') }
    end

    def max_guesses
      puts
      TTY::Prompt.new.ask(
        'Enter the maximum number of guesses :',
        default: 7,
        convert: :int
      ) { |q| q.in('1-26') }
    end

    private_class_method def self.invalid_index
      if SAVED_GAMES.keys.length == 1
        puts
        print('There is only one saved game. Enter 1 to load it')
        return
      end

      puts "Please enter a number in the range 1-#{SAVED_GAMES.keys.length} (inclusive)"
    end
  end
end
