# frozen_string_literal: true

require './spec/spec_helper'
require 'colorize'
require_relative '../lib/chess'

RSpec.describe Chess::Bishop do
  describe '#initialize' do
    it 'initializes the instance variables: location, color' do
      piece = Chess::Bishop.new([0, 0], :white)
      expect(piece.location).to eq([0, 0])
      expect(piece.color).to eq(:white)
    end
  end

  describe Chess::Bishop do
    describe '#valid_moves' do
      it 'returns all diagonal legal moves from a central position' do
        board = Chess::Board.new
        bishop = Chess::Bishop.new([3, 3], :white)
        board[[3, 3]] = bishop

        expected_moves = [
          [2, 2], [1, 1], [0, 0],     # up-left
          [2, 4], [1, 5], [0, 6],     # up-right
          [4, 2], [5, 1], [6, 0],     # down-left
          [4, 4], [5, 5], [6, 6], [7, 7] # down-right
        ]

        expect(bishop.valid_moves(board)).to match_array(expected_moves)
      end
    end
  end
end
