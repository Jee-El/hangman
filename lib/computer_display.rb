# frozen_string_literal: true

require 'tty-prompt'

module Hangman
  module Display
    # Display for computer users
    # It uses some tty-prompt features which can't be used on phone
    # (e.g: replit on phone)
    module ComputerDisplay
      def clarify_rules
        show_guide
        TTY::Prompt.new.keypress('Press any key to continue')
        Display.clear
      end
    end
  end
end
