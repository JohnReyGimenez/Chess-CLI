# frozen_string_literal: true

require './spec/spec_helper'
require 'colorize'
require_relative '../lib/chess'

RSpec.describe Chess::Knight do
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

    it 'returns only valid moves that are in bounds and not blocked by allies' do
      board = double('board')
      allow(board).to receive(:in_bounds?) { |pos| pos.all? { |i| i.between?(0, 7) } }

      allow(board).to receive(:[]).with(2, 3).and_return(double('Piece', color: :white)) # ally
      allow(board).to receive(:[]).with(2, 5).and_return(double('Piece', color: :black)) # enemy
      allow(board).to receive(:[]).and_return(nil)

      knight = Chess::Knight.new([4, 4], :white)
      expected_moves = [
        [2, 5], [3, 2], [3, 6],
        [5, 2], [5, 6], [6, 3], [6, 5]
      ]

      expect(knight.valid_moves(board)).to match_array(expected_moves)
    end
  end
end
