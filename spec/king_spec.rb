# frozen_string_literal: true

require './spec/spec_helper'
require 'colorize'
require_relative '../lib/chess'

RSpec.describe Chess::King do
  describe '#initialize' do
    it 'initializes the instance variables: location, color' do
      piece = Chess::King.new([0, 0], :white)
      expect(piece.location).to eq([0, 0])
      expect(piece.color).to eq(:white)
    end
  end

  describe '#valid_moves' do
    it 'returns only legal 1-step moves for the king' do
      board = double('board')
      allow(board).to receive(:in_bounds?).and_return(true)
      allow(board).to receive(:[]).and_return(nil) # empty board

      king = Chess::King.new([4, 4], :white)
      expected_moves = [
        [3, 3], [3, 4], [3, 5],
        [4, 3],         [4, 5],
        [5, 3], [5, 4], [5, 5]
      ]

      expect(king.valid_moves(board)).to match_array(expected_moves)
    end
  end
end
