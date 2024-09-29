# frozen_string_literal: true

require 'rainbow/refinement'
using Rainbow

Feedback = Struct.new(:exact, :color_only) do
  def to_s
    exacts = Array.new(exact, '●'.red)
    color_onlys = Array.new(color_only, '●'.white)
    (exacts + color_onlys).shuffle.join(' ')
  end
end
