# frozen_string_literal: true

module Chess
  class Bishop < Piece
    WHITE = ♗
    BLACK = ♝
    def bishop_move; end

    def to_s
      case color
      when :white then self.class::WHITE
      else self.class::BLACK
      end
    end
  end
end
