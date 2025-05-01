# frozen_string_literal: true

require './spec/spec_helper'
require 'colorize'
require_relative '../lib/chess'

RSpec.describe Chess::Pawn do
  describe '#initialize' do
    it 'initializes the instance variables: location, color' do
      piece = Chess::Pawn.new([1, 0], :white)
      expect(piece.location).to eq([1, 0])
      expect(piece.color).to eq(:white)
    end

  describe '#has_moved' do
    it 'returns the valid moves that piece has in its current position'
    piece = Chess::Pawn.new([1, 0], :white)
    expect(piece.valid_moves).to eq(3, 0) # it should show all possible moves right?
    # so it should also return [2,0] ?
    end
  end
end
