# frozen_string_literal: true

require_relative 'input'
require 'rainbow/refinement'
using Rainbow

# A human codebreaker: prompts the user for a guess and displaying relevent info
class Codebreaker
  def initialize
    @guesses = [] # list of (guess, feedback)
  end

  def inform_start
    puts 'You are the codebreaker!'
    puts 'Enter a guess by typing the first letter of each color.'
    puts 'For example, to guess Red, Green, Blue, and Yellow, type: rgby'
    puts
  end

  # Prompt the player to guess the code by entering 4 letters,
  # each corresponding to the first letter of a color
  # Loops until a valid guess is made
  # @return [Array] a 4-element array of colors
  def make_guess
    guess = nil
    loop do
      guess_str = Input.get 'Make a guess: '
      guess = guess_str.chars.map { |c| Game::COLOR_MAP.fetch(c.downcase, nil) }.compact
      break unless guess.count != 4

      puts 'Invalid guess input'
    end
    @current_guess = guess
    guess
  end

  def give_feedback(feedback)
    puts "Your guess: #{format_guess} | Feedback: #{format_feedback feedback}"
    puts
    @guesses.push [@current_guess, feedback].freeze
  end

  def format_guess
    @current_guess.map { |e| '⬤'.color(e) }
                  .join('  ')
  end

  def format_feedback(feedback)
    exacts = Array.new(feedback.exact, '●'.red)
    color_onlys = Array.new(feedback.color_only, '●'.white)
    (exacts + color_onlys).shuffle.join(' ')
  end

  def report_outcome(is_winner)
    if is_winner
      puts 'You won!!1'
    else
      puts 'You lost...'
    end
  end
end
