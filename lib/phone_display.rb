require 'tty-box'

module Hangman
  module Display
    module PhoneDisplay
      def clarify_rules
        show_guide
        loop do
          puts 'Press return to continue'
          input = gets.chomp
          puts
          break if input.empty?
        end
        Display.clear
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
