# frozen_string_literal: true

require 'tty-box'

module Hangman
  module Display
    # Display for phone users
    # It doesn't use some tty-prompt features that can't be used on phone
    # (e.g: replit on phone)
    module PhoneDisplay
      GUIDE = "- As a guesser :\n\n"\
        "  You have a limited amount of chances\n\n  to guess the secret word.\n\n"\
        "  Each guess is a letter, regardless of its case (upper/lowercase).\n\n"\
        "- As a maker :\n\n"\
        "  You get a list of words to choose a word from.\n"

      def clarify_rules
        puts
        show_guide
        loop do
          puts
          print 'Press return to continue :'
          input = gets.chomp
          break if input.empty?
        end
        Display.clear
      end

      def show_guide
        puts GUIDE
      end

      def ask_for_human_player_role
        roles_by_nums_str = "1. Word Guesser\n\n2. Word Picker\n"
        puts
        puts TTY::Box.frame(
          roles_by_nums_str,
          padding: [1, 1],
          title: { top_center: ' Choose your role : ' }
        )
        puts
      end

      def valid_role?(role)
        role.match?(/^[12]$/)
      end
    end
  end
end
