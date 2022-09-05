# frozen_string_literal: true

require_relative './game_setup'
require_relative './game'

game_setup = GameSetup.new
game_setup.run
players = game_setup.settings[:players]
word_length = game_setup.settings[:word_length]
game = Game.new(*players, word_length)
game.start
