class Game
  TURNS = 12

  def initialize
    @maker = Codemaker.new
    @breaker = Codebreaker.new
    @code = @maker.make
    @turn = 0
    @guess_correct = false
  end

  def play
    display_instructions
    until over?
      guess = @breaker.guess
      feedback = check_guess guess # represented as struct: Guess = Struct.new(:exact, :color_only)
      @breaker.give_feedback feedback
      @maker.turn_info feedback
      @turn += 1
    end
    on_game_end
  end

  def over?
    @turn > TURNS || @guess_correct
  end

  def check_guess(guess)
    # TODO

    Feedback.new(0, 0)
  end

  def display_instructions
    puts 'Those are the instructions'
  end

  def on_game_end
    @breaker.has_won @guess_correct
    @maker.has_won !@guess_correct
  end
end
