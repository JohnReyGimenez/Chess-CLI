# frozen_string_literal: true

require './spec/spec_helper'
require 'colorize'
require_relative '../lib/chess'

RSpec.describe Chess::Queen do
  describe '#initialize' do
    it 'initializes the instance variables: location, color' do
      piece = Chess::Queen.new([0, 0], :white)
      expect(piece.location).to eq([0, 0])
      expect(piece.color).to eq(:white)
    end
  end

  describe '#valid_moves' do
    it 'returns all valid straight and diagonal moves from a central position' do
      board = Chess::Board.new
      queen = Chess::Queen.new([3, 3], :white)
      board[[3, 3]] = queen

      expected_moves = [
        # Horizontal
        [3, 0], [3, 1], [3, 2], [3, 4], [3, 5], [3, 6], [3, 7],
        # Vertical
        [0, 3], [1, 3], [2, 3], [4, 3], [5, 3], [6, 3], [7, 3],
        # Diagonals
        [2, 2], [1, 1], [0, 0],
        [2, 4], [1, 5], [0, 6],
        [4, 2], [5, 1], [6, 0],
        [4, 4], [5, 5], [6, 6], [7, 7]
      ]

      expect(queen.valid_moves(board)).to match_array(expected_moves)
    end
  end
end
