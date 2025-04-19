module Chess
  class PlayerInput
    def initialize
      @board = board
    end

    def place_pieces(piece_class, row, col, color)
      piece = piece_class.new([row, col], color)
      @board[[row, col]] = piece
    end
  end
end
