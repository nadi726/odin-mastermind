# frozen_string_literal: true

require 'rainbow/refinement'
using Rainbow
require_relative 'code'

# A feedback for a guess, with the number of exact matches and the number of color-only matches
class Feedback
  attr_accessor :exact, :color_only

  def initialize(exact, color_only)
    @exact = exact
    @color_only = color_only
  end

  def to_s
    exacts = Array.new(exact, '●'.red)
    color_onlys = Array.new(color_only, '●'.white)
    (exacts + color_onlys).shuffle.join(' ')
  end

  def ==(other)
    exact == other.exact && color_only == other.color_only
  end

  def self.from_guess(guess, code)
    feedback = Feedback.new(0, 0)
    feedback.exact += count_exact(guess, code)
    feedback.color_only += count_color_only(guess, code)
    feedback
  end

  # Given a guess and a code, count how many exact matches there are
  def self.count_exact(guess, code)
    guess.each_index.filter { |i| guess[i] == code[i] }
         .count
  end

  # Given a guess and a code, count how many color-only matches there are
  def self.count_color_only(guess, code)
    # Don't count exact matches
    remaining_guess = guess.select.with_index { |_, i| guess[i] != code[i] }
    remaining_code = code.select.with_index { |_, i| guess[i] != code[i] }

    Code::ALLOWED_COLORS.sum { |color| [remaining_guess.count(color), remaining_code.count(color)].min }
  end
end
