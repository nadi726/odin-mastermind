# frozen_string_literal: true

# Helper module for the input function
module Input
  # Input with a text directly before, on the same line
  def self.get(text)
    print text
    $stdout.flush
    gets.chomp
  end

  def self.get_code(text)
    loop do
      code_str = Input.get text
      code = code_str.chars.map { |c| Game::COLOR_MAP.fetch(c.downcase, nil) }.compact
      return code unless code.count != 4

      puts 'Invalid input'
    end
  end
end
