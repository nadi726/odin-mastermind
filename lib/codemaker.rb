# frozen_string_literal: true

# A computer codemaker
class Codemaker
  # Creates a random code for the game.
  # @return [Array] a 4-element array of colors from {Game::COLORS}
  def make
    Array.new(4) { Game::COLORS.sample }
  end

  def turn_info(feedback); end
  def report_outcome(is_winner); end
  def inform_start; end
end
