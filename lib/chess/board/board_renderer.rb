# frozen_string_literal: true

require_relative 'board_general'

module Chess
  class BoardRenderer # rubocop:disable Style/Documentation
    SQUARE = '[ ]'
    FLOOR = '+--------+'
    WALLS = '|        |'

    SQUARE_ORDER = 8
    SQUARE_HEIGHT = 3
    attr_reader :square_order, :board

    def initialize(board)
      @board = board
      @square_order = board.class::SQUARE_ORDER
    end

    def render
      square_order.times do |_row|
        square_order.times do |column|
          column != 7 ? print(SQUARE) : puts(SQUARE)
        end
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
