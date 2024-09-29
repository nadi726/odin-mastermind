# frozen_string_literal: true

require_relative 'player'
require_relative '../code'

# A computer codebreaker: randomly guesses a code and takes feedback
class ComputerCodebreaker < Player
  def initialize
    super('Computer player')
    @guesses = []
  end

  def guess_code
    # TODO
    @guess = Code.new %i[red green blue yellow]
    @guess
  end

  def receive_feedback(feedback)
    puts "Computer guess: #{@guess} | Feedback: #{feedback}"
    puts
    @guesses.push [@current_guess, feedback].freeze
  end
end
