# frozen_string_literal: true

module Chess
  class BoardRenderer
    SQUARE = '[ ]'
    attr_reader :square_order

    def initialize(square_order)
      @square_order = square_order
    end

    def render
      square_order.times do |_row|
        square_order.times do |column|
          column != 7 ? print(SQUARE) : print(SQUARE)
        end
      end
    end
  end
end

renderer = BoardRenderer.new(8)

renderer.render
