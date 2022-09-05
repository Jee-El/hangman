# frozen_string_literal: true

require_relative './human_player'
require_relative './computer_player'

# Sets game settings
# i.e word_length, players roles,
class GameSetup
  attr_reader :settings

  def initialize
    @settings = {}
  end

  def run
    @settings[:players] = players
    @settings[:word_length] = word_length.to_i
  end

  private

  def input(question, regex, invalid_input_message = nil)
    print question
    loop do
      input = gets.chomp
      break input if input.match?(regex)

      puts invalid_input_message
    end
  end

  def word_length
    input(
      'Enter the word length, either your word\'s, or computer\'s word : ',
      /^(2|4|6|8){1}$/,
      'Enter a number greater than 1'
    )
  end

  def human_player_role
    input(
      'Do you wanna pick a word or guess? : '\
      "\n1 => pick\n2 => guess\n",
      /^(1|2){1}$/,
      'Enter 1 or 2'
    )
  end

  def human_player_name
    input(
      'Enter your name : ',
      /.*/
    )
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
