# frozen_string_literal: true

# This module contains all the chess game logic, including pieces and rules.
module Chess
  class Rook < Chess::Piece
    WHITE = '♜'.colorize(color: :blue)
    BLACK = '♜'.colorize(color: :black)

    def symbol
      color == :white ? WHITE : BLACK
    end

    def valid_moves(board)
      directions = [
        [-1, 0], # up
        [1, 0],  # down
        [0, -1], # left
        [0, 1]   # right
      ]

      moves = []
      row, col = location

      directions.each do |dr, dc|
        r = row + dr
        c = col + dc
        while board.in_bounds?([r, c])
          target = board[[r, c]]

          # break loop unless target position is empty or has enemy piece
          break unless target.nil? || target.color != color

          moves << [r, c]

          r += dr
          c += dc
        end
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

# moves only left and right and up or down
