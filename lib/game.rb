require_relative 'codebreaker'
require_relative 'codemaker'
require_relative 'feedbacks'

class Game
  TURNS = 12
  COLORS = %i[red green blue yellow white magenta].freeze
  def initialize
    @maker = Codemaker.new
    @breaker = Codebreaker.new
    @code = @maker.make # an array of 4 colors [:red, :green, :white, :blue]
    @turn = 0
    @guess_correct = false
  end

  def play
    display_instructions
    play_turn until over?
    on_game_end
  end

  def play_turn
    @turn += 1
    puts "Turn #{@turn} of #{TURNS}"
    guess = @breaker.guess # an array of 4 colors [:red, :green, :white, :blue]
    feedback = make_feedback guess # represented as struct: Guess = Struct.new(:exact, :color_only)
    @breaker.give_feedback feedback
    @maker.turn_info feedback
    @guess_correct = feedback.exact == 4
  end

  def over?
    @turn >= TURNS || @guess_correct
  end

  def make_feedback(guess)
    feedback = Feedback.new(0, 0)
    feedback.exact += count_exact guess
    feedback.color_only += count_color_only guess
    feedback
  end

  def count_exact(guess)
    guess.each_index.filter { |i| guess[i] == @code[i] }
         .count
  end

  def count_color_only(guess)
    # Don't count exact matches
    remaining_guess = guess.each_index.filter { |i| guess[i] == @code[i] }
    remaining_code = @code.each_index.filter { |i| guess[i] == @code[i] }

    COLORS.sum { |color| [remaining_guess.count(color), remaining_code.count(color)].min }
  end

  def display_instructions
    puts 'Those are the instructions'
  end

  def on_game_end
    @breaker.has_won @guess_correct
    @maker.has_won !@guess_correct
  end
end
