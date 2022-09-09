# frozen_string_literal: true

require 'tty-box'

require_relative './game_setup'
require_relative './phone_display'

module Hangman
  # Setup for phone users
  # It doesn't use some tty-prompt features that can't be used on phone
  # (e.g: replit on phone)
  class PhoneGameSetup < GameSetup
    include PhoneDisplay
  end
end
