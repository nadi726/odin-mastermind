# frozen_string_literal: true

require_relative 'player/human_codebreaker'
require_relative 'player/computer_codebreaker'
require_relative 'player/human_codemaker'
require_relative 'player/computer_codemaker'
require_relative 'feedback'
require_relative 'code'
require_relative 'input'
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
    choice = nil
    choice = (Input.get 'Do you want to be the [1] Codemaker or [2] Codebreaker? ').strip until %w[1 2].include? choice
    puts
    @maker, @breaker = if choice == '1'
                         [HumanCodemaker.new, ComputerCodebreaker.new]
                       else
                         [ComputerCodemaker.new, HumanCodebreaker.new]
                       end
    [@maker, @breaker].each(&:inform_start)
    @code = @maker.create_code
  end

  def play_turn
    @turn += 1
    puts "Turn #{@turn} of #{TURNS}"
    guess = @breaker.guess_code
    feedback = Feedback.from_guess(guess, @code)
    @breaker.receive_feedback feedback
    @guess_correct = feedback.exact == 4
  end

  def over?
    @turn >= TURNS || @guess_correct
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
    puts "The code was: #{@code}"
    if @guess_correct
      puts "The codebreaker #{@breaker.name} won!!!"
    else
      puts "The codemaker #{@maker.name} won!!!"
    end
  end
end
