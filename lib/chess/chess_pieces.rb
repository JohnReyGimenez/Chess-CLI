# frozen_string_literal: true

# lib/chess/chess_pieces.rb

module Chess
  # Class that stores movement logic and other piece variables
  class Piece
    attr_reader :color
    attr_accessor :location, :has_moved

    def initialize(location, color)
      @location = location
      @color = color
      @has_moved = false
    end

    def to_s
      case @color
      when :white then self.class::WHITE
      else self.class::BLACK
      end
    end

    def symbol
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
