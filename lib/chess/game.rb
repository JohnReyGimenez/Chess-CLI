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

    def play_game
      loop do
        start_new_game

        puts 'Do you want to play again? (yes/no)'
        play_again = gets.chomp.downcase
        until %w[yes no].include?(play_again)
          puts 'Invalid input. Please type "yes" or "no".'
          play_again = gets.chomp.downcase
        end
        break if play_again == 'no'
      end
    end

    def display_turn_info(turn_number, current_player)
      color_code = current_player == :white ? 47 : 100
      text_color = current_player == :white ? 30 : 37

      puts "\n\e[1;#{color_code}m Turn #{turn_number} \e[0m  \e[1;#{text_color}m#{current_player.capitalize}'s move\e[0m"
      puts '-' * 45
      puts "↪︎ Move using notation: e.g. 'e2e4'"
      puts "↪︎ Castle with: 'castle k' or 'castle q'"
      puts "↪︎ Type 'exit' to quit."
      puts
    end

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
