# frozen_string_literal: true

# This module contains all the chess game logic, including pieces and rules.
module Chess
  class Knight < Chess::Piece
    WHITE = '♞'.colorize(color: :blue)
    BLACK = '♞'.colorize(color: :black)
  end

  def legal_moves
    # sub
  end
end

# moves in L shape
