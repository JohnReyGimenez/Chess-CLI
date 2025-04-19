# frozen_string_literal: true

require 'colorize'

module Chess
  class Board # rubocop:disable Style/Documentation
    SQUARE_ORDER = 8
    INITIAL_SETUP = [
      [Rook, 0, 0], [Knight, 0, 1], [Bishop, 0, 2], [Queen, 0, 3],
      [King, 0, 4], [Bishop, 0, 5], [Knight, 0, 6], [Rook, 0, 7],
      [Rook, 7, 0], [Knight, 7, 1], [Bishop, 7, 2], [Queen, 7, 3],
      [King, 7, 4], [Bishop, 7, 5], [Knight, 7, 6], [Rook,  7, 7]
    ].freeze

    attr_reader :grid

    def initialize
      # Initialize an 8x8 board with empty spaces
      @grid = Array.new(SQUARE_ORDER) { Array.new(SQUARE_ORDER) }
      @square_order = SQUARE_ORDER
    end

    def [](square)
      row, column = square
      grid[row][column]
    end

    def []=(square, piece)
      row, column = square
      grid[row][column] = piece
    end
  end
end
