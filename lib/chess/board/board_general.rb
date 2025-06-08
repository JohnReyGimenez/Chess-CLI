# frozen_string_literal: true

require 'colorize'
require_relative '../chess_pieces'
require_relative '../player_input'
require_relative 'board_logic'

module Chess
  # handles grid, move_piece_to, reset_board, etc.
  class Board
    include BoardLogic
    SQUARE_ORDER = 8

    # starting setup: [piece class, row, col]
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

    attr_reader :grid, :square_order, :en_passant_target

    def initialize
      # build empty 8x8 grid
      @grid = Array.new(SQUARE_ORDER) { Array.new(SQUARE_ORDER) }
      @square_order = SQUARE_ORDER
      @en_passant_target = nil # set if a pawn moved 2 steps
    end

    def [](square)
      raise "Invalid square argument: #{square.inspect}" unless square.is_a?(Array) && square.size == 2
      row, column = square
      @grid[row][column]
    end

    def []=(square, piece)
      row, column = square
      @grid[row][column] = piece
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

      # place pawns
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
    
    def handle_en_passant(piece, start_pos, end_pos)
      captured_pawn_pos = [start_pos[0], end_pos[1]]
      captured_pawn = self[captured_pawn_pos]
      return unless captured_pawn # <-- prevent nil errors
    
      self[captured_pawn_pos] = nil
      @captured_pieces[captured_pawn.color] << captured_pawn
    end
    

    def move_piece_to(from, to)
      piece = self[from]

      handle_en_passant(from, to, piece)

      # capture if any
      if self[to]
        captured_piece = self[to]
        @captured_pieces[captured_piece.color] << captured_piece
      end

      self[to] = piece
      self[from] = nil
      piece.location = to
      piece.has_moved = true

      # mark en passant square if pawn moved 2 tiles
      if piece.is_a?(Pawn) && (from[0] - to[0]).abs == 2
        direction = piece.color == :white ? -1 : 1
        @en_passant_target = [from[0] + direction, from[1]]
      else
        @en_passant_target = nil
      end
    end

    def board_dup
      Marshal.load(Marshal.dump(self))
    end

    def perform_castling(color, side)
      row = (color == :white ? 7 : 0)
      king_from = [row, 4]
      king_to, rook_from, rook_to =
        if side == 'k'
          [[row, 6], [row, 7], [row, 5]]
        else
          [[row, 2], [row, 0], [row, 3]]
        end

      king = piece_at(king_from)
      rook = piece_at(rook_from)

      move_piece_to(king_from, king_to)
      move_piece_to(rook_from, rook_to)

      king.has_moved = true
      rook.has_moved = true
    end
  end
end
