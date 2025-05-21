# frozen_string_literal: true

module Chess
  class Game # rubocop:disable Style/Documentation
    def initialize
      @board = Board.new
      @board.set_up_board
      @renderer = BoardRenderer.new(@board)
      @current_player_color = :white
      # captured pieces
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

    def move_piece_to(from, to)
      piece = piece_at(from)      # Find the piece to move
      captured = piece_at(to)     # Check if something is at the destination

      # Move the piece on the board
      @grid[to[0]][to[1]] = piece
      @grid[from[0]][from[1]] = nil

      piece.position = to # Update the piece's own position data

      # If it captured an opponent piece, register it
      capture_piece(piece.color, captured) if captured
    end

    def capture_piece(color, captured_piece)
      opponent = color == :white ? :black : :white
      @captured[color] ||= [] # Init array if needed
      @captured[color] << captured_piece if captured_piece.color == opponent
    end
  end
end
