require_relative 'input'
require 'rainbow/refinement'
using Rainbow

class Codebreaker
  COLOR_MAP = { 'r' => :red, 'g' => :green, 'b' => :blue, 'y' => :yellow, 'm' => :magenta, 'w' => :white }.freeze
  def initialize
    @guesses = [] # list of (guess, feedback)
  end

  def inform_start
    puts 'You are the codebreaker!'
    puts 'Enter a guess by typing the first letter of each color.'
    puts 'For example, to guess Red, Green, Blue, and Yellow, type: rgby'
    puts
  end

  def make_guess
    guess = nil
    loop do
      guess_str = Input.get 'Make a guess: '
      guess = guess_str.chars.map { |c| COLOR_MAP.fetch(c.downcase, nil) }
      break unless guess.include?(nil)

      puts 'Invalid guess input'
    end
    @current_guess = guess
    guess
  end

  def give_feedback(feedback)
    puts "Your guess: #{format_guess} | Feedback: #{format_feedback feedback}"
    puts
    @guesses.push [@current_guess, feedback].freeze
  end

  def format_guess
    @current_guess.map { |e| '⬤'.color(e) }
                  .join('  ')
  end

  def format_feedback(feedback)
    exacts = Array.new(feedback.exact, '●'.red)
    color_onlys = Array.new(feedback.color_only, '●'.white)
    (exacts + color_onlys).shuffle.join(' ')
  end

  def has_won(is_true)
    if is_true
      puts 'You won!!1'
    else
      puts 'You lost...'
    end
  end
end
