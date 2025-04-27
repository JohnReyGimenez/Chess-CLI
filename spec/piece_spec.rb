require 'spec_helper'
require_relative '../lib/chess/chess_pieces'

describe Piece do
  describe '#initialize' do
    it 'initializes the instance variables: location, color, has_moved' do
      piece = Chess::Piece.new([0, 0], :white, False)
      expect(piece.location).to eq([0, 0])
      expect(piece.color).to eq(:white)
      expect(piece.has_moved).to eq(false)
    end
  end
end
