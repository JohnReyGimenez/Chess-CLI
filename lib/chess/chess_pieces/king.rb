# frozen_string_literal: true

# This module contains all the chess game logic, including pieces and rules.
module Chess
  class King < Chess::Piece
    WHITE = '♚'.colorize(color: :blue)
    BLACK = '♚'.colorize(color: :black)

    def valid_moves(board)
      row, col = @location
      directions = [
        [-1, -1], [-1, 0], [-1, 1],
        [0, -1], [0, 1], [1, -1],
        [1, 0], [1, 1]
      ]

      moves = []

      directions.each do |dr, dc|
        new_row = row + dr
        new_col = col + dc
        next unless board.in_bounds?([new_row, new_col])

        target = board[new_row][new_col]
        moves << [new_row, new_col] if target.nil? || target.color != color
      end

      moves
    end

    def legal_moves(board)
      valid_moves(board).select do |to_pos|
        test_board = board.board_dup
        test_board.move_piece_to(@location, to_pos)
        !test_board.in_check?(color)
      end
    end
  end
end

# moves on all directions but only one square at a time
#  [row+1, col+1] or [row -1, col-1] for diagonal
#  [row+1, col] or [row, col-1] or vise versa
