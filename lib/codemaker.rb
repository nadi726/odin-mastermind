# frozen_string_literal: true

require_relative 'player'

# A computer codemaker
class Codemaker < Player
  # Creates a random code for the game.
  # @return [Array] a 4-element array of colors from {Game::COLORS}
  def make; end
end
