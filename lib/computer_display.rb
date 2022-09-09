require 'tty-prompt'

module Hangman
  module Display
    module ComputerDisplay
      def clarify_rules
        show_guide
        @prompt.keypress('Press any key to continue')
        Display.clear
      end
    end
  end
end
