module Chess
  class BoardRendered
    SQUARE = '[ ]'
    attr_reader :square_order

    def initialize(square_order)
      @square_order = square_order
    end
  end
end
