# frozen_string_literal: true

# This module contains all the chess game logic, including pieces and rules.
module Chess
  class Queen < Chess::Piece
    WHITE = '♛'.colorize(color: :blue)
    BLACK = '♛'.colorize(color: :black)

    def valid_moves(board)
      # Combine rook and bishop directions
      directions = [
        [-1, 0], [1, 0], [0, -1], [0, 1],     # rook: vertical & horizontal
        [-1, -1], [-1, 1], [1, -1], [1, 1]    # bishop: diagonals
      ]

      row, col = @location
      moves = []

      directions.each do |dr, dc|
        r = row + dr
        c = col + dc

        while board.in_bounds?([r, c])
          target = board[[r, c]]

          if target.nil?
            moves << [r, c]
          elsif target.color != color
            moves << [r, c]
            break
          else
            break
          end

          r += dr
          c += dc
        end
      end

      moves
    end

    def legal_moves(board)
      valid_moves(board).select do |to_pos|
        test_board = board.board_dup
        test_board.move_piece_to(@location, to_pos)
        !test_board.in_check?(color)
      end
    end
  end
end
