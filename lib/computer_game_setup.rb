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
  end
end
