# frozen_string_literal: true

# lib/chess/chess_pieces.rb

require_relative 'chess_pieces/bishop'
require_relative 'chess_pieces/king'
require_relative 'chess_pieces/knight'
require_relative 'chess_pieces/pawn'
require_relative 'chess_pieces/queen'
require_relative 'chess_pieces/rook'

module Chess
  # Class that stores movement logic and other piece variables
  class Piece
    attr_reader :color
    attr_accessor :location

    def initialize(location, color)
      @location = location
      @color = color
    end

    def to_s
      case color
      when :white then self.class::WHITE
      else self.class::BLACK
      end
    end
  end
end
