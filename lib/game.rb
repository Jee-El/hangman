# frozen_string_literal: true

require 'yaml'

require_relative './board'
require_relative './human_player'
require_relative './computer_player'
require_relative './display'

module Hangman
  # A game of hangman
  class Game
    include Display

    attr_reader :guesser, :picker, :board, :words, :secret_word

    def initialize(guesser, picker, words)
      @guesser = guesser
      @picker = picker
      @board = Board.new(words.first.length)
      @words = words
    end

    def start
      show_how_to_save_game
      @secret_word ||= @picker.secret_word(@words)
      save_game if save_game?(@secret_word)
      puts(@board.slots) || puts
      start_guessing
    end

    private

    def start_guessing
      until game_over?
        guess = @guesser.guess.downcase
        return save_game if save_game?(guess)

        @guesser.guesses_count += 1
        clear_screen if @guesser.guesses_count.even?
        @board.update(guess, @secret_word)
      end
      game_over
    end

    def save_game?(input)
      input == ':w'
    end

    def save_game
      saved_games = YAML.safe_load(
        File.read('saved_games.yaml'),
        permitted_classes: [Hangman::Board, Hangman::Game, Hangman::HumanPlayer, Hangman::ComputerPlayer, Symbol]
      ) || {}
      saved_games[:saved_games_count] ||= 0
      saved_games[:saved_games_count] += 1
      index = saved_games[:saved_games_count]
      saved_games[:"saved_game_#{index}"] = self
      File.write('saved_games.yaml', YAML.dump(saved_games), mode: 'a')
    end

    def game_over?
      !@board.slots.include?('_') || @guesser.guesses_count == 7
    end

    def game_over
      puts
      if @guesser.guesses_count == 7
        announce_winner(@picker.name)
      else
        announce_winner(@guesser.name)
      end
    end
  end
end
