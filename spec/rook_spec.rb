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

  describe '#legal_moves' do
    it 'returns the legal and capture moves from current position' do
      board = double('board')
      allow(board).to receive(:in_bounds?).and_return(true)
      allow(board).to receive(:[]).and_return(nil) # simulate empty squares

      piece = Chess::Bishop.new([0, 2], :white)
      expect(piece.legal_moves(board)).to include([1, 3], [2, 4], [1, 1], [2, 0])
      puts piece.legal_moves(board).inspect
    end
  end
end
