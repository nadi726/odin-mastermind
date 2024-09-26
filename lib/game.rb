class Game
  def initialize
    @maker = Codemaker.new
    @breaker = Codebreaker.new
    @code = @maker.make
  end

  def play
  end
end
