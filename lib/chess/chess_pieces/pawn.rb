# frozen_string_literal: true

# This module contains all the chess game logic, including pieces and rules.
module Chess
  class Pawn < Chess::Piece
    WHITE = '♟'.colorize(color: :blue)
    BLACK = '♟'.colorize(color: :black)

    def symbol
      color == :white ? WHITE : BLACK
    end

    def valid_moves(board)
      row, col = @location
      direction = color == :white ? -1 : 1
      moves = []

      # 1-step forward
      one_step = [row + direction, col]
      moves << one_step if board.in_bounds?(one_step) && board[one_step].nil?

      # 2-step forward
      unless has_moved
        two_step = [row + 2 * direction, col]
        moves << two_step if board.in_bounds?(two_step) && board[one_step].nil? && board[two_step].nil?
      end

      # Diagonal captures
      [[row + direction, col - 1], [row + direction, col + 1]].each do |r, c|
        pos = [r, c]
        next unless board.in_bounds?(pos)

        target = board[pos]
        moves << pos if target && target.color != color
      end

      # En passant
      side_captures = [[0, -1], [0, 1]] # left and right same row
      side_captures.each do |dx, dy|
        adjacent = [row + dx, col + dy]
        next unless board.in_bounds?(adjacent)

        target_piece = board[adjacent]
        next unless target_piece.is_a?(Pawn) && target_piece.color != color

        en_passant_square = [row + direction, col + dy]
        moves << en_passant_square if en_passant_square == board.en_passant_target
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
