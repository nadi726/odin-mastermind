require_relative 'player'
require_relative 'formatting'

class ComputerCodebreaker < Player
  def initialize
    super('Computer player')
    @guesses = []
  end

  def make_guess
    # TODO
    @guess = %i[red green blue yellow]
    @guess
  end

  def give_feedback(feedback)
    puts "Computer guess: #{Formatting.code @guess} | Feedback: #{Formatting.feedback feedback}"
    puts
    @guesses.push [@current_guess, feedback].freeze
  end
end
