# frozen_string_literal: true

require_relative 'input'
require_relative 'player'

# A human codebreaker: prompts the user for a guess and displaying relevent info
class HumanCodebreaker < Player
  def initialize
    super('Human player')
  end

  # Prompt the player to guess the code by entering 4 letters,
  # each corresponding to the first letter of a color
  # Loops until a valid guess is made
  # @return [Code] a code of 4 colors
  def make_guess
    puts 'Enter a guess by typing the first letter of each color.'
    puts "For example, to guess #{Code.new %i[red green blue yellow]}, type: rgby"
    puts
    @guess = Input.get_code 'Make a guess: '
    @guess
  end

  def give_feedback(feedback)
    puts "Your guess: #{@guess} | Feedback: #{feedback}"
    puts
  end
end
