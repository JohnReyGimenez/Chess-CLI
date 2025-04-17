# frozen_string_literal: true

# This module contains all the chess game logic, including pieces and rules.
module Chess
  class King < Piece
    WHITE = ♔ # rubocop:disable Naming/AsciiIdentifiers
    BLACK = ♚ # rubocop:disable Naming/AsciiIdentifiers
  end

  def to_s
    case color
    when :white then self.class::WHITE
    else self.class::BLACK
    end
  end
end
