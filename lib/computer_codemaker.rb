class ComputerCodemaker < Player
  def initialize
    super('Computer player')
  end

  # Creates a random code for the game.
  # @return [Array] a 4-element array of colors from {Game::COLORS}
  def make
    Array.new(4) { Game::COLORS.sample }
  end
end
