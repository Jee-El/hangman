# frozen_string_literal: true

require 'tty-box'

module Hangman
  module Displayable
    # For getting the platform name
    module PlatformName
      def self.answer
        platform_names_by_numbers = { '1' => 'phone', '2' => 'computer' }
        question
        loop do
          name = gets.chomp
          break platform_names_by_numbers[name] if platform_names_by_numbers[name]

          print 'Enter either the number 1 or 2 : '
        end
      end

      def self.question
        puts
        puts TTY::Box.frame(
          "1 -> Phone\n\n2 -> Computer",
          padding: [1, 1],
          title: { top_center: ' What device are you on? ' }
        )
      end
    end
  end
end
