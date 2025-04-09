# frozen_string_literal: true

require 'colorize'
require_relative 'board_general'

module Chess
  class BoardRenderer # rubocop:disable Style/Documentation
    SQUARE = '[ ]'
    COLUMN_LETTERS = ('a'..'h').to_a.freeze

    FLOOR_0 = '+--------+'
    FLOOR = '--------+'

    EMPTY_ROW_0 = '|        |'
    EMPTY_ROW_0_WHITE = "|#{'        '.colorize(background: :white)}|"

    EMPTY_ROW = '        |'
    EMPTY_ROW_WHITE = "#{'        '.colorize(background: :white)}|"

    LEFT_MARGIN = '' * 3
    SQUARE_ORDER = 8
    SQUARE_HEIGHT = 3
    attr_reader :square_order, :board

    def initialize(board)
      @board = board
      @square_order = board.class::SQUARE_ORDER
    end

    def render
      print_column_letters

      print_floor
      square_order.times do |row_number|
        print_row(row_number) # top
        print_row(row_number) # middle
        print_row(row_number) # botom
        print_floor
      end
      new_line

      print_column_letters
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
      puts LEFT_MARGIN + FLOOR_0 + FLOOR * (SQUARE_ORDER - 1)
    end

    def print_row(row_number)
      # reverses the row
      puts row_number.even? ? row : row.reverse
    end

    def row
      EMPTY_ROW_0_WHITE +
        (EMPTY_ROW + EMPTY_ROW_WHITE) * 3 +
        EMPTY_ROW
    end

    def print_column_letters
      Chess::BoardRenderer::COLUMN_LETTERS.each { |letter| print "        #{letter}" }
      new_line(2)
    end

    def new_line(lines = 1)
      lines.times { puts '' }
    end
  end
end

board = Chess::Board.new

renderer = Chess::BoardRenderer.new(board)

renderer.render
