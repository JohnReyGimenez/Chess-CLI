# frozen_string_literal: true

require './spec/spec_helper'
require 'colorize'
require_relative '../lib/chess'

RSpec.describe Chess::Rook do
  describe '#initialize' do
    it 'initializes the instance variables: location, color' do
      piece = Chess::Rook.new([0, 0], :white)
      expect(piece.location).to eq([0, 0])
      expect(piece.color).to eq(:white)
    end
  end

  describe '#valid_moves' do
    it 'returns the legal and capture moves from current position' do
      board = double('board')
      allow(board).to receive(:in_bounds?).and_return(true)
      allow(board).to receive(:[]).and_return(nil)

      rook = Chess::Rook.new([3, 3], :white)
      expected_moves = [
        [3, 0], [3, 1], [3, 2], [3, 4], [3, 5], [3, 6], [3, 7],
        [0, 3], [1, 3], [2, 3], [4, 3], [5, 3], [6, 3], [7, 3]
      ]

      expect(rook.valid_moves(board)).to match_array(expected_moves)
    end
  end
end
