# frozen_string_literal: true

require 'colorize'
require 'tty-table'

module Chess
  class Board # rubocop:disable Style/Documentation
    SQUARE_ORDER = 8

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
