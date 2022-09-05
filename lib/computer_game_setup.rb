# frozen_string_literal: true

require 'tty-prompt'

require_relative './game_setup'

module Hangman
  # Setup for computer users
  # It uses some tty-prompt features which can't be used on phone
  # (e.g: replit on phone)
  class ComputerGameSetup < GameSetup
    def clarify_rules
      show_guide
      @prompt.keypress('Press any key to continue')
      clear_screen
    end

    def human_player_role
      puts
      nums_by_roles = { 'Word Guesser' => '1', 'Word Picker' => '2' }
      role = @prompt.select('Choose your role :', ['Word Guesser', 'Word Picker'])
      clear_screen
      nums_by_roles[role]
    end
  end
end
