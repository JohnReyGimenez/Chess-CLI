require 'colorize'
require 'tty-table'

class Board
  attr_accessor :board

  def initialize
    # Initialize an 8x8 board with empty spaces
    @board = Array.new(8) { Array.new(8, ' ') }
  end
end
