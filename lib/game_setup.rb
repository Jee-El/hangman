# frozen_string_literal: true

require 'tty-prompt'

require_relative 'displayable'
require_relative 'human_player'
require_relative 'computer_player'

module Hangman
  # Sets game settings
  # i.e word_length, players roles,
  class GameSetup
    include Displayable

    attr_reader :settings

    def initialize
      @settings = {}
    end

    def run
      clarify_rules
      @settings[:players] = players
      Displayable.clear
      @settings[:words] = words(word_length)
      Displayable.clear
      @settings[:max_guesses] = max_guesses
      Displayable.clear
      yield(@settings)
    end

    private

    def words(word_length)
      File.foreach('dictionary.txt', chomp: true).select { |word| word.length == word_length }
    end

    def human_player_name
      TTY::Prompt.new.ask('Enter your name : ', default: ENV['USER'])
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
