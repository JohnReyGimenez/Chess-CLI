require 'spec_helper'
require_relative '../lib/chess/chess_pieces'

describe Piece do
  describe '#initialize' do
    it 'initializes the instance variables: location, color, has_moved'
    piece = Chess::Piece.new
    expect(piece)
  end
end
