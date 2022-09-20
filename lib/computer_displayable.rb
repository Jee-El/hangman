# frozen_string_literal: true

require 'tty-prompt'

module Hangman
  module Displayable
    # Display for computer users
    # It uses some tty-prompt features which can't be used on phone
    # (e.g: replit on phone)
    module ComputerDisplayable
      def clarify_rules
        Displayable.clear
        show_guide
        TTY::Prompt.new.keypress('Press any key to continue')
        Displayable.clear
      end

      def show_guide
        puts TTY::Box.frame(GUIDE, padding: [1, 1], border: :ascii)
      end
    end
  end
end
