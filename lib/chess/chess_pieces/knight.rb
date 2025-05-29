# frozen_string_literal: true

# This module contains all the chess game logic, including pieces and rules.
module Chess
  class Knight < Chess::Piece
    WHITE = '♞'.colorize(color: :blue)
    BLACK = '♞'.colorize(color: :black)

    def valid_moves(board)
      row, col = @location
      move_offsets = [
        [-2, -1], [-2, 1], [-1, -2], [-1, 2],
        [1, -2], [1, 2], [2, -1], [2, 1]
      ]

      moves = []

      move_offsets.each do |dr, dc|
        new_pos = [row + dr, col + dc]
        next unless board.in_bounds?(new_pos)

        # checks for new position
        target = board[new_pos[0]][new_pos[1]]
        # Either empty or enemy piece
        moves << new_pos if target.nil? || target.color != color
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
