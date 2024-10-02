# frozen_string_literal: true

require_relative 'player'
require_relative '../code'

# A computer codebreaker: randomly guesses a code and takes feedback
# Uses the Swaszek strategy
class ComputerCodebreaker < Player
  def initialize
    super('Computer player')
    @s = (Code::ALLOWED_COLORS.repeated_permutation 4).to_a # Set of all posssible permutations
    @guess = @s.delete first_guess # start with guess [1, 1, 2, 2]
  end

  def guess_code
    @guess
  end

  def receive_feedback(feedback)
    puts "Computer guess: #{@guess} | Feedback: #{feedback}"
    puts
    get_next_guess(feedback)
  end

  def get_next_guess(feedback)
    # Remove all guesses that don't produce the same feedback, if they were the secret code
    @s = @s.select { |e| Feedback.from_guess(@guess, e) == feedback }
    @guess = @s.shift
    @guess ||= first_guess # For the (seemingly impossible) edge case that @s is empty # rubocop:disable Naming/MemoizedInstanceVariableName
  end

  private

  def first_guess
    one = Code::ALLOWED_COLORS[0]
    two = Code::ALLOWED_COLORS[1]
    [one, one, two, two]
  end
end
