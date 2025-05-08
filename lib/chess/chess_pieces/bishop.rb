# frozen_string_literal: true

# This module contains all the chess game logic, including pieces and rules.
module Chess
  class Bishop < Chess::Piece
    WHITE = '♝'.colorize(color: :blue)
    BLACK = '♝'.colorize(color: :black)
  end

  def legal_moves
    # sub
  end
end

# moves only diagonally so [row+1, col+1] or [row -1, col-1]
# valid moves are basically added or subtracted until it reaches all diagonals...
