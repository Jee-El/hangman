# frozen_string_literal: true

require 'tty-box'

require_relative './game_setup'

module Hangman
  # Setup for phone users
  # It doesn't use some tty-prompt features that can't be used on phone
  # (e.g: replit on phone)
  class PhoneGameSetup < GameSetup
    def clarify_rules
      show_guide
      loop do
        puts 'Press return to continue'
        input = gets.chomp
        puts
        break if input.empty?
      end
      clear_screen
    end

    def human_player_role
      puts
      ask_for_human_player_role
      loop do
        print 'Enter either the number 1 or 2 : '
        role = gets.chomp
        puts
        break if valid_role?
      end
      clear_screen
      role
    end

    def ask_for_human_player_role
      roles_by_nums_str = "1 => Word Guesser\n2 => Word Picker\n"
      puts
      puts TTY::Box.frame(
        roles_by_nums_str,
        padding: [1, 1],
        title: { top_center: ' Choose your role : ' }
      )
      puts
    end

    def valid_role?
      %w[1 2].include?(role)
    end
  end
end
