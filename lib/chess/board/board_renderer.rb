# frozen_string_literal: true

require_relative 'board_general'

module Chess
  class BoardRenderer # rubocop:disable Style/Documentation
    SQUARE = '[ ]'
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
  end
end

board = Chess::Board.new

renderer = Chess::BoardRenderer.new(board)

renderer.render
