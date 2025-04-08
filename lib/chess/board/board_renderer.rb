# frozen_string_literal: true

require 'colorize'
require_relative 'board_general'

module Chess
  class BoardRenderer # rubocop:disable Style/Documentation
    SQUARE = '[ ]'
    FLOOR_0 = '+--------+'
    FLOOR = '--------+'

    EMPTY_ROW_0 = '|        |'
    EMPTY_ROW_0_WHITE = "|#{'        '.colorize(background: :white)}|"
    EMPTY_ROW = '        |'
    EMPTY_ROW_WHITE = "#{'        '.colorize(background: :white)}|"

    SQUARE_ORDER = 8
    SQUARE_HEIGHT = 3
    attr_reader :square_order, :board

    def initialize(board)
      @board = board
      @square_order = board.class::SQUARE_ORDER
    end

    def render
      print_floor

      square_order.times do |_row|
        SQUARE_HEIGHT.times { print_row }
        print_floor
      end
    end

    def square_content(square)
      if board[square].nil
        '[ ]'
      elsif board[square].is_a(knight)
        "[#{board[square].class.to_s[2]}]"
      else
        "[#{board[square.class.to_s[0]]}]"
      end
    end

    def print_floor
      puts FLOOR_0 + FLOOR * (SQUARE_ORDER - 1)
    end

    def print_row
      puts WALLS_0 + WALLS * (SQUARE_ORDER - 1)
    end
  end
end

board = Chess::Board.new

renderer = Chess::BoardRenderer.new(board)

renderer.render
