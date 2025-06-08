# frozen_string_literal: true

# lib/chess/chess_pieces.rb

module Chess
  # base class for all pieces – stores color, location, movement state
  class Piece
    attr_reader :color
    attr_accessor :location, :has_moved

    def initialize(location, color)
      @location = location
      @color = color
      @has_moved = false # useful for castling, pawn logic
    end

    def to_s
      # return unicode symbol for rendering
      case @color
      when :white then self.class::WHITE
      else self.class::BLACK
      end
    end

    def symbol
      # fallback symbol access if needed
      const_name = color == :white ? 'WHITE' : 'BLACK'
      self.class.const_defined?(const_name) ? self.class.const_get(const_name) : '?'
    end
  end
end

require_relative 'chess_pieces/bishop'
require_relative 'chess_pieces/king'
require_relative 'chess_pieces/knight'
require_relative 'chess_pieces/pawn'
require_relative 'chess_pieces/queen'
require_relative 'chess_pieces/rook'
