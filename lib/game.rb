# frozen_string_literal: true

require 'yaml'

require_relative './board'
require_relative './display'

module Hangman
  # A game of hangman
  class Game
    include Display

    attr_reader :guesser, :picker, :board, :words

    def initialize(guesser, picker, word_length)
      @saved_games = YAML.safe_load(
        File.read('saved_games.yaml'),
        permitted_classes: [Board, ComputerPlayer, Game, HumanPlayer]
      ) || {}
      @is_resuming_game = resume?
      @is_resuming_game ? resume_game : new_game(guesser, picker, word_length)
    end

    def start
      show_how_to_save_game
      word = @picker.secret_word(@words) unless @is_resuming_game
      save_game if save_game?(word)
      puts(@board.slots) || puts
      start_guessing(word)
    end

    private

    def start_guessing(word)
      until game_over?
        guess = @guesser.guess.downcase
        return save_game if save_game?(guess)

        @guesser.guesses_count += 1
        clear_screen if @guesser.guesses_count.even?
        @board.update(guess, word)
      end
      game_over(word)
    end

    def resume?
      return if @saved_games.empty?

      puts 'Do you wanna start a new game, or resume?'
      puts "1 => resume\n 2 => new game\n"
      answer = gets.chomp.downcase
      return true if answer == '1'
    end

    def new_game(guesser, picker, word_length)
      @saved_games[:saved_games_count] ||= 0
      @guesser = guesser
      @picker = picker
      @board = Board.new(word_length)
      @words = File.foreach('dictionary.txt').map(&:chomp).filter do |line|
        line.length == word_length
      end
    end

    def save_game?(word)
      word == ':w'
    end

    def save_game
      @saved_games[:saved_games_count] += 1
      @saved_games["saved_game_#{@saved_games[:saved_games_count]}"] = self
      File.write('saved_games.yaml', YAML.dump(@saved_games))
    end

    def game_over?
      !@board.slots.include?('_') || @guesser.guesses_count == 7
    end

    def game_over(word)
      puts
      if @guesser.guesses_count == 7
        announce_winner(@picker.name, word)
      else
        announce_winner(@guesser.name)
      end
    end
  end
end
