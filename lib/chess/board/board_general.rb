# frozen_string_literal: true

require 'colorize'
require 'tty-table'

module Chess
  class Board # rubocop:disable Style/Documentation
    SQUARE_ORDER = 8

    attr_reader :square_order, :board

    def initialize
      # Initialize an 8x8 board with empty spaces
      @board = Array.new(8) { Array.new(8, ' ') }
      @square_order = SQUARE_ORDER
    end
  end
end
