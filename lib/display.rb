# frozen_string_literal: true

require 'tty-box'

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

    def show_how_to_change_list
      puts || puts('Press enter to change the list') || puts
    end

    def already_guessed
      puts || puts('Please enter a letter') || puts
    end

    def announce_winner(winner_name, word)
      puts TTY::Box.frame(
        winner_name,
        padding: [1, 1],
        align: :center,
        title: { top_center: ' The Winner Is ', bottom_center: ' Good Game ' }
      )
      puts || puts("The Secret Word Was : #{word}") || puts
    end

    def print_words_list(words)
      puts(words[0, 6].join(', ')) || puts
    end

    def clear_screen
      puts "\e[1;1H\e[2J"
    end
  end
end
