# frozen_string_literal: true

require 'yaml'

require_relative './board'

# A game of hangman
class Game
  attr_reader :guesser, :maker, :board, :words

  def initialize(guesser, maker, word_length)
    @saved_games = YAML.safe_load(
      File.read('saved_games.yaml'),
      permitted_classes: [Board, ComputerPlayer, Game, HumanPlayer]
    )
    @is_resuming_game = resume?
    @is_resuming_game ? resume_game : new_game(guesser, maker, word_length)
  end

  def start
    puts 'Type :w any time you want to save & quit the game'
    word = @maker.secret_word(@words) unless @is_resuming_game
    save_game if save_game?(word)
    puts @board.slots
    until game_over?
      puts 'guess'
      guess = @guesser.guess.downcase
      return save_game if save_game?(guess)

      @guesser.guesses_count += 1
      puts @board.update(guess, word)
    end
    game_over(word)
  end

  private

  def resume?
    return if @saved_games.empty?

    puts 'Do you wanna start a new game, or resume?'
    puts "1 => resume\n 2 => new game\n"
    answer = gets.chomp.downcase
    return true if answer == '1'
  end

  def new_game(guesser, maker, word_length)
    @saved_games[:saved_games_count] ||= 0
    @guesser = guesser
    @maker = maker
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
    puts 'Game Over'
    if @guesser.guesses_count == 7
      puts "The Winner Is : #{@maker.name}"
      puts "The Secret Word Was : #{word}"
    else
      puts "The Winner Is : #{@guesser.name}"
    end
  end
end
