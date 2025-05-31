# frozen_string_literal: true

require_relative 'board/board_general'

module Chess
  # Class that stores movement logic and other piece variables
  class PlayerInput
    def initialize
      @board = board
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
