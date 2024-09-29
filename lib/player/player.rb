# frozen_string_literal: true

# A base class representing a player in the game
class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end
end
