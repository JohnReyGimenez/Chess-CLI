require './spec/spec_helper'
require 'colorize'
require_relative '../lib/chess'

RSpec.describe Chess::Rook do
  describe '#initialize' do
    it 'initializes the instance variables: location, color, has_moved' do
      piece = Chess::Rook.new([0, 0], :white, false)
      expect(piece.location).to eq([0, 0])
      expect(piece.color).to eq(:white)
      expect(piece.has_moved).to eq(false)
    end
  end
end