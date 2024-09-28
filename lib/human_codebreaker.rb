# frozen_string_literal: true

require_relative 'input'
require_relative 'formatting'
require 'rainbow/refinement'
using Rainbow
require_relative 'codebreaker'

# A human codebreaker: prompts the user for a guess and displaying relevent info
class HumanCodebreaker < Codebreaker
  def initialize
    super('Human player')
  end

  # Prompt the player to guess the code by entering 4 letters,
  # each corresponding to the first letter of a color
  # Loops until a valid guess is made
  # @return [Array] a 4-element array of colors
  def make_guess
    puts 'Enter a guess by typing the first letter of each color.'
    puts 'For example, to guess Red, Green, Blue, and Yellow, type: rgby'
    puts
    @guess = Input.get_code 'Make a guess: '
    @guess
  end

  def give_feedback(feedback)
    puts "Your guess: #{Formatting.code @guess} | Feedback: #{Formatting.feedback feedback}"
    puts
  end
end
