# frozen_string_literal: true

require 'tty-prompt'

require_relative './display'
require_relative './human_player'
require_relative './computer_player'

module Hangman
  # Sets game settings
  # i.e word_length, players roles,
  class GameSetup
    include Display

    attr_reader :settings

    def initialize
      @settings = {}
    end

    def run
      clarify_rules
      @settings[:players] = players
      @settings[:word_length] = word_length
      @settings[:max_guesses] = max_guesses
    end

    private

    def human_player_name
      name = TTY::Prompt.new.ask('Enter your name : ', default: ENV['USER'])
      Display.clear
      name
    end

    def players
      players = [
        HumanPlayer.new(human_player_name),
        ComputerPlayer.new('Computer')
      ]
      case human_player_role
      when '1' then players
      when '2' then players.rotate
      end
    end
  end
end
