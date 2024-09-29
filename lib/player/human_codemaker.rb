# frozen_string_literal: true

require_relative 'player'
require_relative '../input'

# A human codemaker: prompts the user for a secret code
class HumanCodemaker < Player
  def initialize
    super('Human player')
  end

  # Prompt the player for a secret code
  # @return [Code] a code of 4 colors
  def create_code
    code = Input.get_code 'Your code: '
    puts "Your code is: #{code}"
    code
  end

  def inform_start
    puts 'You are the codemaker!'
    puts 'Choose a code by typing the first letter of each color.'
    puts "For example, to choose the code #{Code.new %i[red green blue yellow]}, type: rgby"
    puts
  end
end
