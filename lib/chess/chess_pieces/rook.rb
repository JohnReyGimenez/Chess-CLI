# frozen_string_literal: true

# This module contains all the chess game logic, including pieces and rules.
module Chess
  class Rook < Chess::Piece
    WHITE = '♜'.colorize(color: :blue)
    BLACK = '♜'.colorize(color: :black)
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

        # vreak loop unless target position is empty or has enemy piece
        break unless target.nil? || target.color != colorize

        moves << [r, c]

        r += dr
        c += dc
      end
    end

    moves
  end
end

# moves only left and right and up or down
