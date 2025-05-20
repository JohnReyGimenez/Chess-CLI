# frozen_string_literal: true

module Chess
  # Class that stores movement logic and other piece variables
  class PlayerInput
    def initialize
      @board = board
    end

    def self.get_move
      loop do
        print '> '
        input = gets.chomp.strip.downcase

        return input if valid_move_input?(input)

        puts "Invalid input format. Try 'e2e4' or 'castle k'."
      end
    end

    def valid_move_input?(input)
      input = input.downcase.strip
      return true if input == 'exit'
      return true if ['castle k', 'castle q'].include?(input)
      return false unless input.length == 4

      from = input[0..1]
      to = input[2..3]
      valid_positions = ('a'..'h').to_a.product((1..8).to_a).map { |l, n| "#{l}#{n}" }

      valid_positions.include?(from) && valid_positions.include?(to)
    end
  end
end
