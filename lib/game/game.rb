# frozen_string_literal: true

require 'yaml'

require_relative '../board/board'
require_relative '../player/human_player/human_player'
require_relative '../player/computer_player/computer_player'
require_relative '../displayable/displayable'

module Hangman
  # A game of hangman
  class Game
    @saved_games = YAML.safe_load_file(
      'saved_games.yaml',
      permitted_classes: [Board, Game, HumanPlayer, ComputerPlayer, Symbol, Time]
    ) || []

    include Displayable

    attr_reader :guesser, :picker, :board, :words, :secret_word

    def initialize(guesser, picker, words, max_guesses)
      @guesser = guesser
      @picker = picker
      @board = Board.new(words.first.length, max_guesses)
      @words = words
    end

    def start
      show_how_to_save_game
      explain_board_format

      @secret_word ||= @picker.secret_word(@words)

      Game.save(self) if save_game?(@secret_word)

      [@board.slots, @board.wrong_guesses].each { |elem| print(elem) || print(' | ') }

      start_guessing
    end

    def self.resume?
      !@saved_games.empty? && TTY::Prompt.new.yes?('Do you want to resume a game?')
    end

    def self.load(platform_name)
      puts
      saved_game = case platform_name
                   when 'computer' then ComputerGameSetup.saved_game_to_load
                   when 'phone' then PhoneGameSetup.saved_game_to_load
                   end
      Displayable.clear
      saved_game[:game].start
    end

    def self.save(game)
      puts
      name = TTY::Prompt.new.ask('Name your saved game : ', default: "unnamed_#{@saved_games.length}")
      puts
      new_saved_game = { name: name, timestamp: Time.now, game: game }
      @saved_games.push(new_saved_game)
      File.write('saved_games.yaml', YAML.dump(@saved_games))
    end

    private

    def start_guessing
      until game_over?
        guess = @guesser.guess
        return Game.save(self) if save_game?(guess)

        Displayable.clear

        @board.draw(guess, @secret_word)
      end
      game_over
    end

    def save_game?(input)
      input == ':w'
    end

    def game_over?
      !@board.slots.include?('_') || @board.left_guesses.zero?
    end

    def game_over
      if @board.left_guesses.zero?
        announce_winner(@picker.name)
      else
        announce_winner(@guesser.name)
      end
    end
  end
end
