# frozen_string_literal: true

# This module contains all the chess game logic, including pieces and rules.
module Chess
  class Pawn < Chess::Piece
    WHITE = '♟'.colorize(color: :blue)
    BLACK = '♟'.colorize(color: :black)

    def valid_moves(board)
      row, col = @location
      direction = color == :white ? -1 : 1 # direction
      moves = []

      # 1-step
      one_step = [row + direction, col]
      moves << one_step if board.in_bounds?(one_step) && board[one_step[0]][one_step[1]].nil?

      # 2-step
      two_step = [row + 2 * direction, col]
      moves << two_step if board.in_bounds?(one_step) && board[one_step[0]][one_step[1]].nil?

      # Diagonal captures
      [[row + direction, col - 1], [row + direction, col + 1]].each do |r, c|
        next unless board.in_bounds?([r, c])

        target = board[r][c]
        moves << [r, c] if target && target.color != color
      end

      moves
    end
  end
end
