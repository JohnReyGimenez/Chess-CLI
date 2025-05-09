# frozen_string_literal: true

# This module contains all the chess game logic, including pieces and rules.
module Chess
  class Bishop < Chess::Piece
    WHITE = '♝'.colorize(color: :blue)
    BLACK = '♝'.colorize(color: :black)

    def valid_moves(board)
      row, col = @location

      # All 4 diagonal directions
      directions = [
        [-1, -1], [-1, 1],
        [1, -1],  [1, 1]
      ]

      moves = []

      directions.each do |dr, dc|
        new_row = row + dr
        new_col = col + dc

        while board.in_bounds?([new_row, new_col])
          target = board[new_row][new_col]

          if target.nil? # if square is empty
            moves << [new_row, new_col]
          elsif target.color != color # if enemy valid but brekas when capture
            moves << [new_row, new_col]
            break
          else
            break # if friendly break
          end

          new_row += dr
          new_col += dc
        end
      end

      moves
    end
  end
end

# moves only diagonally so [row+1, col+1] or [row -1, col-1]
# valid moves are basically added or subtracted until it reaches all diagonals...
