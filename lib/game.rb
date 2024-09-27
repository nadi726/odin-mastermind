require_relative 'codebreaker'
require_relative 'codemaker'
require_relative 'feedbacks'
require 'rainbow/refinement'
using Rainbow

class Game
  TURNS = 12
  COLORS = %i[red green blue yellow white magenta].freeze
  def initialize
    @maker = nil
    @breaker = nil
    @code = nil
    @turn = 0
    @guess_correct = false
  end

  def play
    display_instructions
    choose_players
    play_turn until over?
    on_game_end
  end

  def choose_players
    @maker = Codemaker.new
    @breaker = Codebreaker.new
    @code = @maker.make # an array of 4 colors [:red, :green, :white, :blue]
    @maker.inform_start
    @breaker.inform_start
  end

  def play_turn
    @turn += 1
    puts "Turn #{@turn} of #{TURNS}"
    guess = @breaker.make_guess # an array of 4 colors [:red, :green, :white, :blue]
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
    remaining_guess = guess.select.with_index { |_, i| guess[i] != @code[i] }
    remaining_code = @code.select.with_index { |_, i| guess[i] != @code[i] }
    COLORS.sum { |color| [remaining_guess.count(color), remaining_code.count(color)].min }
  end

  def display_instructions # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
    puts 'Welcome to Mastermind!'
    puts
    puts 'This is a 2-player game:'
    puts '- One player is the Codemaker, tasked with creating a secret code.'
    puts '- The other is the Codebreaker, who tries to guess the code.'
    puts
    puts 'The Codebreaker wins by guessing the code before running out of turns.'
    puts 'The Codemaker wins if the Codebreaker fails to do so.'
    puts
    puts 'The code consists of 4 colors, chosen from 6 available colors,'
    puts 'with possible repetitions.'
    puts "The available colors are: #{format_colors}"
    puts "You have #{TURNS} turns to guess the code."
    puts
    puts 'Feedback is provided for each guess:'
    puts "- A #{'red'.red} circle means both color and position are correct."
    puts "- A #{'white'.white} circle means only the color is correct."
    puts 'The feedback order is randomized.'
    puts
    puts 'Good luck!'
    puts
  end

  def format_colors
    COLORS.map { |c| c.to_s.color(c) }.join(', ')
  end

  def on_game_end
    @breaker.has_won @guess_correct
    @maker.has_won !@guess_correct
  end
end
