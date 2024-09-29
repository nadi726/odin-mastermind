# frozen_string_literal: true

require_relative 'player'
require_relative 'code'

class ComputerCodebreaker < Player
  def initialize
    super('Computer player')
    @guesses = []
  end

  def make_guess
    # TODO
    @guess = Code.new %i[red green blue yellow]
    @guess
  end

  def give_feedback(feedback)
    puts "Computer guess: #{@guess} | Feedback: #{feedback}"
    puts
    @guesses.push [@current_guess, feedback].freeze
  end
end
