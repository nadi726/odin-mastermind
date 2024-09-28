require_relative 'input'
require_relative 'formatting'
require_relative 'codemaker'

class HumanCodemaker < Codemaker
  def initialize
    super('Human player')
  end

  def make
    puts 'Choose a code by typing the first letter of each color.'
    puts "For example, to choose the code #{Formatting.code(%i[red green blue yellow])}, type: rgby"
    puts
    code = Input.get_code 'Your code: '
    puts "Your code is: #{Formatting.code code}"
    code
  end
end
