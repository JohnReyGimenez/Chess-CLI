# frozen_string_literal: true

module Chess
  class Game # rubocop:disable Style/Documentation
    def initialize
      @board = Board.new
      @board.set_up_board
      @renderer = BoardRenderer.new(@board)
      @current_player_color = :white
      @captured = { white: [], black: [] }
    end

    def play_game; end

    def ask_for_move
      puts "\nEnter your move (e.g. 'e2e4', 'castle k', or 'exit')"
      Chess::PlayerInput.get_move
    end

    def castle(color, side)
      # later: Add logic for king and rook movement, safety checks, etc.
      puts "#{color.capitalize} castled #{side == 'k' ? 'kingside' : 'queenside'}."
    end
  end
end
