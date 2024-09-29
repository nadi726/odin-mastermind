# frozen_string_literal: true

require_relative 'player'
require_relative '../input'

# A human codebreaker: prompts the user for a guess and displaying relevent info
class HumanCodebreaker < Player
  def initialize
    super('Human player')
  end

  # Prompt the player to guess the code
  # @return [Code] a code of 4 colors
  def guess_code
    puts 'Enter a guess by typing the first letter of each color.'
    puts "For example, to guess #{Code.new %i[red green blue yellow]}, type: rgby"
    puts
    @guess = Input.get_code 'Make a guess: '
    @guess
  end

  def receive_feedback(feedback)
    puts "Your guess: #{@guess} | Feedback: #{feedback}"
    puts
  end
end
