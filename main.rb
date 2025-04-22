# frozen_string_literal: true

require_relative 'lib/chess'

board = Chess::Board.new
board.set_up_board

renderer = Chess::BoardRenderer.new(board)
renderer.render

Chess::BoardRenderer.new(board).render
