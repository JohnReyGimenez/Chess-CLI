# frozen_string_literal: true

# This module contains all the chess game logic, including pieces and rules.
module Chess
  class Pawn < Chess::Piece
    WHITE = '♟'.colorize(color: :blue)
    BLACK = '♟'.colorize(color: :black)
    DIRECTION = color == :white ? -1 : 1
  end

  def valid_moves(board)
    valid_moves = []
    # sub
  end

  def forward_moves(board)
    next_row = current_row + DIRECTION
    valid_moves << [next_row, current_col] if board[[next_row, current_col]].nil
  end
end
