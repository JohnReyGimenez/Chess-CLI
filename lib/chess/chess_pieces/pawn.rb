# frozen_string_literal: true

# This module contains all the chess game logic, including pieces and rules.
module Chess
  class Pawn < Chess::Piece
    WHITE = '♟'.colorize(color: :blue)
    BLACK = '♟'.colorize(color: :black)
    DIRECTION = color == :white ? -1 : 1
  end

  def valid_move(board)
    valid_moves = []
    # sub
  end

  def forward_moves(board)
    next_row = 
  end
end
