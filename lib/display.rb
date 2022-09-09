# frozen_string_literal: true

require 'tty-box'

require_relative './board'
require_relative './computer_player'
require_relative './human_player'
require_relative './game'

module Hangman
  # Messages to be displayed to the player(s)
  module Display
    GUIDE = "- As a guesser :\n\n"\
      "  You have a limited amount of chances\n\n  to guess the secret word.\n\n"\
      "  Each guess is a letter, regardless of its case (upper/lowercase).\n\n"\
      "- As a maker :\n\n"\
      "  You get a list of words to choose a word from.\n"
    WELCOME = "Welcome\n\nTo Hangman"
    SAVING_GAME = 'Type :w any time you want to save & quit the game'

    def self.welcome
      puts TTY::Box.frame(WELCOME,
                          padding: [1, 2],
                          align: :center,
                          border: :ascii,
                          enable_color: true,
                          style: {  bg: :blue,
                                    fg: :white })
      puts
    end

    def show_guide
      puts TTY::Box.frame(GUIDE, padding: [1, 1], border: :ascii)
    end

    def show_how_to_save_game
      puts || puts(SAVING_GAME) || puts
    end

    def explain_board_format
      puts || puts('secret word slots | wrong guesses | left guesses') || puts
    end

    def show_how_to_change_list
      puts || puts('Press enter to change the list') || puts
    end

    def invalid_word
      puts 'Please enter a word that\'s part of the list'
    end

    def already_guessed(guess)
      "You've already guessed #{guess}"
    end

    def not_a_letter(guess)
      "#{guess} is not a letter. Please enter a letter."
    end

    def announce_winner(winner_name)
      puts
      puts("The Secret Word Was : #{@secret_word}") || puts
      puts TTY::Box.frame(
        winner_name,
        padding: [1, 1],
        align: :center,
        title: { top_center: ' The Winner Is ', bottom_center: ' Good Game ' }
      )
      puts
    end

    def print_words_list(words)
      puts(words[0, 6].join(', ')) || puts
    end

    def self.clear
      puts "\e[1;1H\e[2J"
    end
  end
end
