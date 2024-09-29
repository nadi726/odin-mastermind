# frozen_string_literal: true

require_relative 'player'
require_relative 'code'

class ComputerCodemaker < Player
  def initialize
    super('Computer player')
  end

  # Creates a random code for the game.
  # @return [Code] a code of 4 colors
  def make
    Code.new(Array.new(4) { Code::ALLOWED_COLORS.sample })
  end
end
