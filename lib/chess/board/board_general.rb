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

    attr_reader :grid, :square_order

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

    def in_bounds?(pos)
      row, col = pos
      row.between?(0, 7) && col.between?(0, 7)
    end

    def place_pieces(piece_class, row, col, color)
      piece = piece_class.new([row, col], color)
      self[[row, col]] = piece
    end

    def set_up_board
      INITIAL_SETUP.each do |color, pieces|
        pieces.each do |piece_class, row, column|
          place_pieces(piece_class, row, column, color)
        end
      end

      # places pawns
      8.times do |col|
        place_pieces(Pawn, 1, col, :black)
        place_pieces(Pawn, 6, col, :white)
      end
    end

    def position_to_notation(row, col)
      "#{('a'.ord + col).chr}#{8 - row}"
    end

    def piece_at(pos)
      row, col = pos
      @grid[row][col]
    end

    def parse_position(pos)
      col = pos[0].ord - 'a'.ord
      row = 8 - pos[1].to_i
      [row, col]
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

    def in_check?(color)
      king_pos = nil

      # find the king of the given color
      grid.each do |row|
        row.each do |piece|
          next unless piece.is_a?(King) && piece.color == color

          king_pos = piece.position
          break
        end
      end

      return false unless king_pos # in case king was not found

      # check every opponent piece to see if it can attack the king
      grid.each do |row|
        row.each do |piece|
          next if piece.nil? || piece.color == color

          moves = piece.valid_moves(self)
          return true if moves.include?(king_pos)
        end
      end

      false
    end
  end
end
