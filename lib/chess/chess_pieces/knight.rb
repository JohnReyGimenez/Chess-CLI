# frozen_string_literal: true

module Chess
  class Knight < Piece
    WHITE = ♘
    BLACK = ♞
  end

  def to_s
    case color
    when :white then self.class::WHITE
    else self.class::BLACK
    end
  end
end
