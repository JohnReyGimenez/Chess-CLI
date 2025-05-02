# frozen_string_literal: true

# This module contains all the chess game logic, including pieces and rules.
module Chess
  class Pawn < Chess::Piece
    WHITE = '♟'.colorize(color: :blue)
    BLACK = '♟'.colorize(color: :black)
  end

  def valid_moves(board)
    row, col = @location
    direction = color == :white ? -1 : 1 # direction
    moves = []

    # 1-step
    one_step = [row + direction, col]
    moves << one_step if board[one_step[0]][one_step[1]].nil?

    # 2-step
    two_step = [row + 2 * direction, col]
    moves << two_step if !@has_moved && board[one_step[0]][one_step[1]].nil? && board[two_step[0]][two_step[1]].nil?

    # Diagonal captures would go here later
    moves
  end

  def forward_moves(board)
    next_row = current_row + DIRECTION
    valid_moves << [next_row, current_col] if board[[next_row, current_col]].nil
  end
end
