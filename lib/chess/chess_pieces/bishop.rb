# frozen_string_literal: true

# This module contains all the chess game logic, including pieces and rules.
module Chess
  class Bishop < Chess::Piece # rubocop:disable Style/Documentation
    WHITE = '♗'
    BLACK = '♝'

    def to_s
      case color
      when :white then self.class::WHITE
      else self.class::BLACK
      end
    end
  end
end
