# frozen_string_literal: true

require_relative 'human_codebreaker'
require_relative 'computer_codebreaker'
require_relative 'human_codemaker'
require_relative 'computer_codemaker'
require_relative 'feedbacks'
require_relative 'formatting'
require_relative 'code'
require 'rainbow/refinement'
using Rainbow

# A class for handling game flow
class Game
  TURNS = 12

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
    @maker = HumanCodemaker.new
    @breaker = ComputerCodebreaker.new
    @code = @maker.make
  end

  def play_turn
    @turn += 1
    puts "Turn #{@turn} of #{TURNS}"
    guess = @breaker.make_guess
    feedback = make_feedback guess
    @breaker.give_feedback feedback
    @guess_correct = feedback.exact == 4
  end

  def over?
    @turn >= TURNS || @guess_correct
  end

  # @return [Feedback] the feedback for the given guess, represented as exact and color_only counts
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

    Code::ALLOWED_COLORS.sum { |color| [remaining_guess.count(color), remaining_code.count(color)].min }
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
    puts "The available colors are: #{Code.format_allowed_colors}"
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

  def on_game_end
    puts "The code was: #{Formatting.code @code}"
    if @guess_correct
      puts "The codebreaker #{@breaker.name} won!!!"
    else
      puts "The codemaker #{@maker.name} won!!!"
    end
  end
end
