# frozen_string_literal: true

module Chess
  class BoardLogic
    def pieces_for(color)
      @grid.flatten.compact.select { |p| p.color == color }
    end

    def in_check?(color)
      king_pos = nil

      # find the king of the given color
      @grid.each do |row|
        row.each do |piece|
          next unless piece.is_a?(King) && piece.color == color

          king_pos = piece.location
          break
        end
      end

      return false unless king_pos # in case king was not found

      # check every opponent piece to see if it can attack the king
      @grid.each do |row|
        row.each do |piece|
          next if piece.nil? || piece.color == color

          moves = piece.valid_moves(self)
          return true if moves.include?(king_pos)
        end
      end

      false
    end

    def checkmate?(color)
      return false unless in_check?(color)

      pieces_for(color).each do |piece|
        piece.valid_moves(self).each do |move|
          # clone board to test the move
          test_board = board_dup

          # simulate move on the test board
          test_piece = test_board[piece.location]
          test_board.move_piece_to(test_piece.location, move)

          # if move gets the king out of check then not checkmate
          return false unless test_board.in_check?(color)
        end
      end

      true
    end

    def stalemate?(color)
      return false if in_check?(color)

      pieces_for(color).each do |piece|
        piece.valid_moves(self).each do |move|
          test_board = board_dup
          test_piece = test_board[piece.location]
          test_board.move_piece_to(test_piece.location, move)
          return false unless test_board.in_check?(color)
        end
      end

      true
    end

    def find_king(color)
      @grid.each do |row|
        row.each do |piece|
          return piece.location if piece.is_a?(King) && piece.color == color
        end
      end
      nil
    end

    def can_castle?(color, side)
      king_pos = find_king(color)
      return false unless king_pos

      king = piece_at(king_pos)
      return false unless king.is_a?(King) && !king.has_moved

      row = king_pos[0]
      rook_col = (side == 'k' ? 7 : 0)
      rook = piece_at([row, rook_col])
      return false unless rook.is_a?(Rook) && !rook.has_moved

      path_cols = side == 'k' ? [5, 6] : [1, 2, 3]
      return false unless path_cols.all? { |col| piece_at([row, col]).nil? }

      ([4] + path_cols).all? do |col|
        temp_board = board_dup
        temp_board.move_piece_to(king_pos, [row, col])
        !temp_board.in_check?(color)
      end
    end
  end
end
