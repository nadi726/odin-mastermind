require_relative 'codebreaker'
require_relative 'formatting'

class ComputerCodebreaker < Codebreaker
  def initialize
    super('Computer player')
    @guesses = []
  end

  def give_feedback(feedback)
    puts "Computer guess: #{Formatting.code @guess} | Feedback: #{Formatting.feedback feedback}"
    puts
    @guesses.push [@current_guess, feedback].freeze
  end

  def make_guess
    # TODO
    @guess = %i[red green blue yellow]
    @guess
  end
end
