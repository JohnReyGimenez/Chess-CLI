# frozen_string_literal: true

require_relative 'board/board_general'

module Chess
  # Class that stores movement logic and other piece variables
  class PlayerInput
    def initialize
      @board = board
    end

    def self.valid_move_input?(input)
      input = input.downcase.strip
      return true if input == 'exit'
      return true if ['castle k', 'castle q'].include?(input)
      return false unless input.length == 4

      from = input[0..1]
      to = input[2..3]
      valid_positions = ('a'..'h').to_a.product((1..8).to_a).map { |l, n| "#{l}#{n}" }

      valid_positions.include?(from) && valid_positions.include?(to)
    end

    def self.get_move
      loop do
        print "Enter your move (e.g., 'e2 e4') or 'save': "
        input = gets.chomp.strip.downcase

        return :save if input == 'save'
        return input if valid_move_input?(input)

        puts "Invalid move format. Try again (e.g., 'e2 e4')"
      end
    end
  end
end
