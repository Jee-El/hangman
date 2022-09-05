# frozen_string_literal: true

require_relative './player'

class HumanPlayer < Player
  def guess
    loop do
      guess = gets.chomp
      break made_guesses.push(guess) && guess if valid_guess?(guess)
      break guess if guess == ':w'

      invalid_guess(guess)
    end
  end

  def valid_guess?(guess)
    guess.gsub(' ', '').match?(/^[a-z]{1}$/i) && !made_guesses.include?(guess)
  end

  def invalid_guess(guess)
    return puts 'Not a letter' if made_guesses.include?(guess)

    puts "You've already guessed #{guess}"
  end

  def secret_word(words)
    puts 'Press enter to change the list'
    loop do
      puts 'Choose one word of this list :'
      puts words[0, 6].join(', ')
      word = gets.chomp
      break word if valid_word?(word, words) || word == ':w'

      next words.rotate!(6) if word.empty?

      invalid_word
    end
  end

  def valid_word?(word, words)
    words.include?(word)
  end

  def invalid_word
    puts 'Not a valid word'
  end
end
