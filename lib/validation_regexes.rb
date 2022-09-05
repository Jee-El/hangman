# frozen_string_literal: true

module Hangman
  module ValidationRegexes
    WORD_LENGTH = { regex: /^\d{1}$/, error: 'Please enter a number <= 18 : ' }.freeze
    MAX_GUESSES = { regex: /^\d{1}$/, error: 'Please enter a number : ' }.freeze
    VALID_GUESS = { regex: /^[a-z]{1}$/i, error: 'Please enter a letter :' }.freeze
  end
end
