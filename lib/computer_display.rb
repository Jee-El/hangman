# frozen_string_literal: true

require 'tty-prompt'

module Hangman
  module Display
    # Display for computer users
    # It uses some tty-prompt features which can't be used on phone
    # (e.g: replit on phone)
    module ComputerDisplay
      GUIDE = "- As a guesser :\n\n"\
        "  You have a limited amount of chances\n\n  to guess the secret word.\n\n"\
        "  Each guess is a letter, regardless of its case (upper/lowercase).\n\n"\
        "- As a maker :\n\n"\
        "  You get a list of words to choose a word from.\n"

      def clarify_rules
        Display.clear
        show_guide
        TTY::Prompt.new.keypress('Press any key to continue')
        Display.clear
      end

      def show_guide
        puts TTY::Box.frame(GUIDE, padding: [1, 1], border: :ascii)
      end
    end
  end
end
