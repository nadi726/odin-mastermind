require_relative 'input'

class Codebreaker
  COLOR_MAP = { 'r' => :red, 'g' => :green, 'b' => :blue, 'y' => :yellow, 'm' => :magenta, 'w' => :white }.freeze
  def initialize
    @guesses = [] # list of (guess, feedback)
  end

  def guess
    loop do
      guess_str = Input.get 'Make a guess: '
      guess = guess_str.chars.map { |c| COLOR_MAP.fetch(c.downcase, nil) }
      return guess unless guess.any? nil

      puts 'Invalid guess input'
    end
  end

  def give_feedback(feedback)
    puts "Feedback: #{feedback}"
  end

  def has_won(is_true)
    if is_true
      puts 'You won!!1'
    else
      puts 'You lost...'
    end
  end
end
