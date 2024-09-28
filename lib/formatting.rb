require 'rainbow/refinement'
using Rainbow

module Formatting
  def self.code(code)
    code.map { |e| '⬤'.color(e) }
        .join('  ')
  end

  def self.feedback(feedback)
    exacts = Array.new(feedback.exact, '●'.red)
    color_onlys = Array.new(feedback.color_only, '●'.white)
    (exacts + color_onlys).shuffle.join(' ')
  end
end
