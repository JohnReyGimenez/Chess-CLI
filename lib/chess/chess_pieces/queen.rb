# frozen_string_literal: true

# This module contains all the chess game logic, including pieces and rules.
module Chess
  class Queen < Chess::Piece
    WHITE = '♛'.colorize(color: :blue)
    BLACK = '♛'.colorize(color: :black)
  end

  def valid_move
    # sub
  end
end
