# frozen_string_literal: true

require_relative 'board_general'

module Chess
  class BoardRenderer
    SQUARE = '[ ]'
    attr_reader :square_order, :board

    def initialize(board)
      @board = board
      @square_order = square_order
    end

    def render
      square_order.times do |_row|
        square_order.times do |column|
          column != 7 ? print(SQUARE) : puts(SQUARE)
        end
      end
    end

    def square_content(square)
      "[#{board[square.class.to_s[0]]}]"
    end
  end
end

renderer = Chess::BoardRenderer.new(board)

renderer.render
