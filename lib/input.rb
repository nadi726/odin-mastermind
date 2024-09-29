# frozen_string_literal: true

require_relative 'code'

# Helper module for the input function
module Input
  # Input with a text directly before, on the same line
  def self.get(text)
    print text
    $stdout.flush
    gets.chomp
  end

  # Get a 4 letter code, with each letter signifying a color,
  # and convert to an array of 4 colors.
  # Loops until a valid code is given
  # @return [Code] a code of 4 colors
  def self.get_code(text)
    loop do
      code_str = Input.get text
      begin
        code = Code.from_str code_str
        return code
      rescue ArgumentError => e
        puts e
      end
    end
  end
end
