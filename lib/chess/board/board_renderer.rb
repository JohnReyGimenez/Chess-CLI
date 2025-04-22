# frozen_string_literal: true

require 'colorize'
require_relative 'board_general'

module Chess
  class BoardRenderer # rubocop:disable Style/Documentation
    # below are layout formatting constants
    ROW_NUMBERS = [*('1'..'8')].reverse
    SQUARE = '[ ]'
    COLUMN_LETTERS = ('a'..'h').to_a.freeze

    FLOOR_0 = '+--------+'
    FLOOR = '--------+'

    EMPTY_ROW_0 = "|#{'        '.colorize(background: :green)}|"
    EMPTY_ROW_0_WHITE = "|#{'        '.colorize(background: :white)}|"

    EMPTY_ROW = "#{'        '.colorize(background: :green)}|"
    EMPTY_ROW_WHITE = "#{'        '.colorize(background: :white)}|"

    LEFT_MARGIN = ' ' * 4
    RIGHT_MARGIN = ' ' * 3
    SQUARE_ORDER = 8
    SQUARE_HEIGHT = 3

    attr_reader :square_order, :board

    def initialize(board)
      @board = board
      @square_order = board.class::SQUARE_ORDER
    end

    def render # rubocop:disable Metrics/MethodLength
      new_line
      print_column_letters
      print_floor

      square_order.times do |row_number|
        print_row(row_number)
        print ROW_NUMBERS[row_number]
        print_piece_row(row_number)
        puts RIGHT_MARGIN + ROW_NUMBERS[row_number]
        print_row(row_number)
        print_floor
      end
      new_line

      print_column_letters
    end

    def square_content(square)
      piece = board[square]
      return '   ' if piece.nil?

      " #{piece} "
    end

    def print_floor
      puts LEFT_MARGIN + FLOOR_0 + FLOOR * (SQUARE_ORDER - 1)
    end

    def print_row(row_number)
      puts row_number.even? ? white_starting_row : black_starting_row
    end

    def white_starting_row
      LEFT_MARGIN +
        EMPTY_ROW_0_WHITE +
        (EMPTY_ROW + EMPTY_ROW_WHITE) * 3 +
        EMPTY_ROW
    end

    def black_starting_row
      LEFT_MARGIN +
        EMPTY_ROW_0 +
        (EMPTY_ROW_WHITE + EMPTY_ROW) * 3 +
        EMPTY_ROW_WHITE
    end

    def print_column_letters
      Chess::BoardRenderer::COLUMN_LETTERS.each { |letter| print "        #{letter}" }
      new_line(2)
    end

    def print_piece_row(row)
      SQUARE_ORDER.times do |column|
        square = [row, column]

        if white_square?(square) then print_white_square(square, column)
        else
          print_black_square(square, column)
        end
      end
    end

    def new_line(lines = 1)
      lines.times { puts '' }
    end

    def white_square?(square)
      row = square.first
      column = square.last

      row.even? && column.even? || row.odd? && column.odd?
    end

    def print_white_square(square, column)
      if board[square].nil? && column.zero?
        print '   |'
        print "    #{board[square]}    ".colorize(background: :white)
        print '|'
      elsif column.zero?
        print '   |'
        print "   #{board[square]}    ".colorize(background: :white)
        print '|'
      elsif board[square].nil?
        print "    #{board[square]}    ".colorize(background: :white)
        print '|'
      else
        print "   #{board[square]}    ".colorize(background: :white)
        print '|'
      end
    end

    def print_black_square(square, column) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
      if board[square].nil? && column.zero?
        print '   |'
        print "  #{board[square]}      ".colorize(background: :green)
        print '|'
      elsif column.zero?
        print '   |'
        print "   #{board[square]}    ".colorize(background: :green)
        print '|'
      elsif board[square].nil?
        print "   #{board[square]}     ".colorize(background: :green)
        print '|'
      else
        print "   #{board[square]}    ".colorize(background: :green)
        print '|'
      end
    end
  end
end
