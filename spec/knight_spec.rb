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
    it 'returns all valid L-shaped moves for a central knight on empty board' do
      board = double('board')
      allow(board).to receive(:in_bounds?) { |pos| pos.all? { |i| i.between?(0, 7) } }
      allow(board).to receive(:[]).and_return(nil)

      knight = Chess::Knight.new([4, 4], :white)

      expected_moves = [
        [2, 3], [2, 5], [3, 2], [3, 6],
        [5, 2], [5, 6], [6, 3], [6, 5]
      ]

      expect(knight.valid_moves(board)).to match_array(expected_moves)
    end
  end
end
