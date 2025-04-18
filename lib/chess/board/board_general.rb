# frozen_string_literal: true

require 'colorize'
require_relative '../chess_pieces'
require_relative '../player_input'

module Chess
  class Board # rubocop:disable Style/Documentation
    SQUARE_ORDER = 8
    # format: [piece_class, row, col]
    INITIAL_SETUP = {
      black: [
        [Rook, 0, 0], [Knight, 0, 1], [Bishop, 0, 2], [Queen, 0, 3],
        [King, 0, 4], [Bishop, 0, 5], [Knight, 0, 6], [Rook, 0, 7]
      ],
      white: [
        [Rook, 7, 0], [Knight, 7, 1], [Bishop, 7, 2], [Queen, 7, 3],
        [King, 7, 4], [Bishop, 7, 5], [Knight, 7, 6], [Rook, 7, 7]
      ]
    }.freeze

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

    def place_pieces(piece_class, row, col, color)
      piece = piece_class.new([row, col], color)
      @board[[row, col]] = piece
    end

    def set_up_board
      INITIAL_SETUP.each do |color, pieces|
        pieces.each do |piece_class, row, column|
          place_pieces(piece_class, row, column, color)
        end
      end

      # places pawns
      8.times do |col|
        place_piece(Pawn, 1, col, :black)
        place_piece(Pawn, 6, col, :white)
      end
    end
  end
end
