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
  end
end
