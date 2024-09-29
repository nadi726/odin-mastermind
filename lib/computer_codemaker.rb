# frozen_string_literal: true

require_relative 'player'
require_relative 'code'

# A computer codemaker: generates a random code for the game.
class ComputerCodemaker < Player
  def initialize
    super('Computer player')
  end

  # @return [Code] a code of 4 colors
  def make
    Code.new(Array.new(4) { Code::ALLOWED_COLORS.sample })
  end
end
