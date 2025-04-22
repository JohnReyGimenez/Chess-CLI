# frozen_string_literal: true

# This module contains all the chess game logic, including pieces and rules.
module Chess
  class Rook < Chess::Piece
    WHITE = '♖'
    BLACK = '♜'.colorize(color: :black)
  end
end
