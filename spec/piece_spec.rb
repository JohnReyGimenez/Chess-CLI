# frozen_string_literal: true

require './spec/spec_helper'
require 'colorize'
require_relative '../lib/chess'

RSpec.describe Chess::Piece do
  describe '#initialize' do
    it 'initializes the instance variables: location, color' do
      piece = Chess::Piece.new([0, 0], :white)
      expect(piece.location).to eq([0, 0])
      expect(piece.color).to eq(:white)
    end
  end
end
