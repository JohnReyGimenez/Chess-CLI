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

      expected_moves = []

      expect(queen.valid_moves(board)).to match_array(expected_moves)
    end
  end
end
