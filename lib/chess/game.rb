# frozen_string_literal: true

module Chess
  class Game # rubocop:disable Style/Documentation
    def initialize
      @board = Board.new
      @board.set_up_board
      @renderer = BoardRenderer.new(@board)
      @current_player_color = :white
    end

    def play_game; end

    def ask_for_move
      puts "\nEnter your move (e.g. 'e2e4', 'castle k', or 'exit')"
      Chess::PlayerInput.get_move
    end
  end
end
