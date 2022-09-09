# frozen_string_literal: true

require 'tty-prompt'

require_relative './display'
require_relative './validation_regexes'
require_relative './human_player'
require_relative './computer_player'

module Hangman
  # Sets game settings
  # i.e word_length, players roles,
  class GameSetup
    include ValidationRegexes
    include Display

    attr_reader :settings

    def initialize
      @prompt = TTY::Prompt.new
      @settings = {}
    end

    def run
      clarify_rules
      @settings[:players] = players
      @settings[:word_length] = word_length
    end

    private

    def word_length
      puts
      word_length = @prompt.ask('Enter the secret word\'s length', default: 7) do |q|
        q.modify :strip
        q.validate WORD_LENGTH[:regex]
        q.messages[:valid?] = WORD_LENGTH[:error]
      end.to_i
      Display.clear
      word_length
    end

    def human_player_name
      name = @prompt.ask('Enter your name : ', default: ENV['USER'])
      Display.clear
      name
    end

    def max_guesses
      puts
      max_guesses = @prompt.ask('Enter the maximum number of guesses :', default: 7) do |q|
        q.modify :strip
        q.validate MAX_GUESSES[:regex]
        q.messages[:valid?] = MAX_GUESSES[:error]
      end
      Display.clear
      max_guesses
    end

    def players
      players = [
        ComputerPlayer.new('Computer'),
        HumanPlayer.new(human_player_name)
      ]
      case human_player_role
      when '1' then players
      when '2' then players.rotate
      end
    end
  end
end
