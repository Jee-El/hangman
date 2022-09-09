require 'tty-box'

module Hangman
  module Display
    module PhoneDisplay
      SAVED_GAMES = YAML.safe_load(
        File.read('saved_games.yaml'),
        permitted_classes: [Board, Game, HumanPlayer, ComputerPlayer, Symbol, Time]
      ) || {}

      def self.list_saved_games
        saved_games_list = ''
        SAVED_GAMES.keys.each_with_index { |saved_game, i| saved_games_list << i.to_s << '. ' << saved_game << "\n\n" }
        TTY::Box.frame(
          saved_games_list,
          padding: [1, 1],
          title: { top_center: ' Choose a game : ' }
        )
        saved_games_list
      end

      def self.saved_game_to_load
        saved_games_list = list_saved_games
        loop do
          index = gets.chomp

          if index.match?(/^#{[*1..SAVED_GAMES.keys.length - 1]}$/)
            chosen_saved_game_name = saved_games_list.split("\n\n").filter do |saved_game|
              saved_game.start_with?(index)
            end
            chosen_saved_game_name = chosen_saved_game_name.split(' ', 2)[1]
            break SAVED_GAMES[chosen_saved_game_name.to_sym]
          end

          invalid_index
        end
      end

      def self.invalid_index
        puts "Please enter a number from 1 to #{SAVED_GAMES.keys.length - 1}"
      end

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

      def human_player_role
        puts
        ask_for_human_player_role
        loop do
          print 'Enter either the number 1 or 2 : '
          role = gets.chomp
          puts
          break Display.clear || role if valid_role?(role)
        end
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
