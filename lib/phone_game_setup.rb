require 'tty-box'

require_relative './game_setup'
require_relative './phone_display'

module Hangman
  # Setup for phone users
  # It doesn't use some tty-prompt features that can't be used on phone
  # (e.g: replit on phone)
  class PhoneGameSetup < GameSetup
    include PhoneDisplay

    SAVED_GAMES = YAML.safe_load(
      File.read('saved_games.yaml'),
      permitted_classes: [Board, Game, HumanPlayer, ComputerPlayer, Symbol, Time]
    ) || {}

    def self.saved_game_to_load
      saved_games_list = list_saved_games
      loop do
        index = gets.chomp

        if index.match?(/^#{[*1..SAVED_GAMES.keys.length]}$/)
          Display.clear

          chosen_saved_game_name = saved_games_list.split("\n\n").find do |saved_game|
            saved_game.start_with?(index)
          end
          chosen_saved_game_name = chosen_saved_game_name.split(' ', 2)[1]
          break SAVED_GAMES[chosen_saved_game_name.to_sym]
        end

        invalid_index
      end
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

    def word_length
      puts
      word_length = TTY::Prompt.new.ask(
        'Enter the secret word\'s length',
        default: 7,
        convert: :int
      ) do |q|
        q.modify :strip
        q.in('2-18')
        q.messages[:valid?] = 'Please enter a number in the range 2-18 (inclusive)'
      end
      Display.clear
      word_length
    end

    def max_guesses
      puts
      max_guesses = TTY::Prompt.new.ask('Enter the maximum number of guesses :', default: 7) do |q|
        q.modify :strip
        q.in('2-26')
        q.messages[:valid?] = 'Please enter a number.'
      end
      Display.clear
      max_guesses
    end

    private_class_method def self.list_saved_games
      saved_games_list = ''
      SAVED_GAMES.each.with_index(1) do |hash, i|
        saved_games_list << i.to_s << '. ' << hash[0].to_s << " -> #{hash[1][:timestamp]}" << "\n\n"
      end
      TTY::Box.frame(saved_games_list, padding: [1, 1], title: { top_center: ' Choose a game : ' })
      puts 'Choose a game :'
      puts
      puts saved_games_list
      saved_games_list
    end

    private_class_method def self.invalid_index
      return puts || print('There is only one saved game. Enter 1 to load it') if SAVED_GAMES.keys.length == 1

      puts "Please enter a number in the range 1-#{SAVED_GAMES.keys.length} (inclusive)"
    end
  end
end
