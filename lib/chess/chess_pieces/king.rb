# frozen_string_literal: true

# This module contains all the chess game logic, including pieces and rules.
module Chess
  class King < Chess::Piece
    WHITE = '♚'.colorize(color: :blue)
    BLACK = '♚'.colorize(color: :black)
  end

  def valid_move
    row, col = @location
    directions = [
      [-1, -1], [-1, 0], [-1, 1],
      [0, -1], [0, 1], [1, -1],
      [1, 0], [1, 1]
    ]

    moves = []
  end
end

# moves on all directions but only one square at a time
#  [row+1, col+1] or [row -1, col-1] for diagonal
#  [row+1, col] or [row, col-1] or vise versa
