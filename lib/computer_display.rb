require 'tty-prompt'

module Hangman
  module Display
    module ComputerDisplay
      SAVED_GAMES = YAML.safe_load(
        File.read('saved_games.yaml'),
        permitted_classes: [Board, Game, HumanPlayer, ComputerPlayer, Symbol, Time]
      ) || {}

      def self.saved_game_to_load
        saved_game = TTY::Prompt.new.select('Choose a game :', SAVED_GAMES.keys[1..])
        SAVED_GAMES[saved_game.to_sym]
      end

      def clarify_rules
        show_guide
        @prompt.keypress('Press any key to continue')
        Display.clear
      end

      def human_player_role
        puts
        roles_to_nums = { 'Word Guesser' => '1', 'Word Picker' => '2' }
        role = @prompt.select('Choose your role :', ['Word Guesser', 'Word Picker'])
        Display.clear
        roles_to_nums[role]
      end
    end
  end
end
