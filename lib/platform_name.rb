# frozen_string_literal: true

require 'tty-box'

module Hangman
  module Display
    module PlatformName
      def self.get
        platform_names_by_numbers = { '1' => 'phone', '2' => 'computer' }
        ask
        loop do
          name = gets.chomp
          break platform_names_by_numbers[name] if name.strip.match?(/^[12]$/)

          print 'Enter either the number 1 or 2 : '
        end
      end

      def self.ask
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
