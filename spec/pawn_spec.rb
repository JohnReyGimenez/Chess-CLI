# frozen_string_literal: true

require 'spec_helper'
require 'colorize'
require_relative '../lib/chess/chess'

Rspec.describe Chess::Pawn do
  describe '#initialize' do
    it 'initializes the instance variables: location, color, has_moved' do
      piece = Chess::Pawn.new([1, 0], :white, false)
      expect(piece.location).to eq([1, 0])
      expect(piece.color).to eq(:white)
      expect(piece.has_moved).to eq(false)
    end
  end
end
