# frozen_string_literal: true

module Chess
  # game loop, turn tracking
  class Game
    def initialize
      @board = Board.new
      @board.set_up_board
      @renderer = BoardRenderer.new(@board)
      @current_player_color = :white
      # captured pieces
      @captured = { white: [], black: [] }
    end

    def play_game
      turn = 1
      loop do
        system('clear')                    # clears terminal
        @renderer.render                   # renders the current board state
        display_turn_info(turn, @current_player_color)

        # checks for game end conditions
        if @board.checkmate?(@current_player_color)
          puts "#{@current_player_color.capitalize} is checkmated! Game over."
          break
        elsif @board.stalemate?(@current_player_color)
          puts "Stalemate! It's a draw."
          break
        end

        # prompts and parses player move
        move_input = ask_for_move
        break if move_input == 'exit'

        # handles castling separately
        if move_input.start_with?('castle')
          handle_castling(move_input)
          turn += 1
          switch_players
          next
        end

        # parse and validate
        from, to = parse_move(move_input)
        if from && to && valid_move?(from, to)
          @board.move_piece_to(from, to)
          check_promotion(to)
          turn += 1
          switch_players
        else
          puts 'Invalid move. Try again.'
        end
      end
    end

    def display_turn_info(turn_number, current_player)
      color_code = current_player == :white ? 47 : 100
      text_color = current_player == :white ? 30 : 37

      puts "\n\e[1;#{color_code}m Turn #{turn_number} \e[0m  \e[1;#{text_color}m#{current_player.capitalize}'s move\e[0m"
      puts '-' * 45
      puts "> Move using notation: e.g. 'e2e4'"
      puts "> Castle with: 'castle k' or 'castle q'"
      puts "> Type 'exit' to quit."
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

    def capture_piece(color, captured_piece)
      opponent = color == :white ? :black : :white
      @captured[color] ||= [] # Init array if needed
      @captured[color] << captured_piece if captured_piece.color == opponent
    end

    def switch_players
      @current_player_color = @current_player_color == :white ? :black : :white
    end
  end
end
