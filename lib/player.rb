require 'rainbow/refinement'
using Rainbow

class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end
end
