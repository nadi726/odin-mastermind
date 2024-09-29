# frozen_string_literal: true

require 'rainbow/refinement'
using Rainbow

# Represents a code of 4 colors, from a pool of allowed colors
class Code < Array
  attr_reader :colors

  ALLOWED_COLORS = %i[red green blue yellow magenta white].freeze
  # Correlate each color to its starting letter
  COLOR_MAP = ALLOWED_COLORS.to_h { |color| [color.to_s[0], color] }.freeze

  def initialize(colors)
    validate_code colors
    super(colors.freeze)
  end

  def validate_code(colors)
    raise ArgumentError, 'A code must consist of exactly 4 colors' if colors.count != 4

    return unless colors.any? { |c| !ALLOWED_COLORS.include? c }

    raise ArgumentError, 'A code must consist of only allowed colors'
  end

  def self.format_allowed_colors
    ALLOWED_COLORS.map { |c| c.to_s.color(c) }.join(', ')
  end

  def self.from_str(str)
    colors = str.chars.map { |c| COLOR_MAP.fetch(c.downcase, nil) }
    Code.new colors
  end
end
