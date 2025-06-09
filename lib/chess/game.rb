# frozen_string_literal: true

require_relative 'player_input'
require_relative 'save_load'

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
        system('clear')
        @renderer.render
        @renderer.render_captured(@captured)
        display_turn_info(turn, @current_player_color)

        # Game end conditions
        if @board.checkmate?(@current_player_color)
          puts "#{@current_player_color.capitalize} is checkmated! Game over."
          break
        elsif @board.stalemate?(@current_player_color)
          puts "Stalemate! It's a draw."
          break
        end

        # Prompt player input
        move_input = ask_for_move
        break if move_input == 'exit'

        if move_input == :save
          SaveLoad.new.save_game(self)
          puts 'Game saved. Exiting.'
          break
        end

        # Castling logic (e.g., 'castle k' or 'castle q')
        if move_input.start_with?('castle')
          handle_castling(move_input)

          # notify player if castling puts opponent in check
          puts "#{opponent_color.capitalize} is in check!" if @board.in_check?(opponent_color)

          turn += 1
          switch_players
          next
        end

        from, to = parse_move(move_input)

        if from && to && valid_move?(from, to)
          target_piece = @board.piece_at(to)
          @board.move_piece_to(from, to)

          # capture logic after move, check what piece was removed
          captured_piece = target_piece || (@board.en_passant_target && !@board.piece_at(to).is_a?(Pawn) ? nil : nil)
          capture_piece(@current_player_color, captured_piece) if captured_piece

          check_promotion(to)

          # check status after move
          puts "#{opponent_color.capitalize} is in check!" if @board.in_check?(opponent_color)

          turn += 1
          switch_players
        else
          puts 'Invalid move. Try again.'
        end
      end
    end

    def display_turn_info(turn_number, current_player)
      puts "\nTurn #{turn_number}  #{current_player.capitalize}'s move"
      puts '─' * 45
      puts "> Move using notation: e.g. 'e2e4'"
      puts "> Castle with: 'castle k' or 'castle q'"
      puts "> Type 'exit' to quit."
      puts
    end

    def ask_for_move
      puts "\nEnter your move (e.g. 'e2e4', 'castle k', 'save', or exit'):"
      Chess::PlayerInput.get_move
    end

    # feedback after successful castling (main output comes from handle_castling)
    def castle(color, side)
      puts "#{color.capitalize} castled #{side == 'k' ? 'kingside' : 'queenside'}."
    end

    # track captured pieces for each side
    def capture_piece(color, captured_piece)
      opponent = color == :white ? :black : :white
      @captured[opponent] ||= [] # Init array for opponent if needed
      @captured[opponent] << captured_piece if captured_piece
    end

    # move validation scoped to current player's turn
    def valid_move?(from, to)
      piece = @board[from]
      return false unless piece # no piece at that location
      return false unless piece.color == @current_player_color

      piece.legal_moves(@board).include?(to)
    end

    def switch_players
      @current_player_color = @current_player_color == :white ? :black : :white
    end

    # convert notation (e.g. 'e2') to board coordinates
    def parse_position(str)
      col_map = { 'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3, 'e' => 4, 'f' => 5, 'g' => 6, 'h' => 7 }
      return nil unless str.length == 2 && col_map.key?(str[0]) && str[1].to_i.between?(1, 8)

      row = 8 - str[1].to_i
      col = col_map[str[0]]
      [row, col]
    end

    # handle full move strings like 'e2e4'
    def parse_move(input)
      input = input.strip.downcase
      return nil unless input.length == 4

      from = input[0..1]
      to = input[2..3]
      [parse_position(from), parse_position(to)]
    end

    # pawn promotion prompt (defaults to Queen if invalid input)
    def check_promotion(to)
      piece = @board.piece_at(to)
      return unless piece.is_a?(Pawn)
      return unless (piece.color == :white && to[0] == 0) || (piece.color == :black && to[0] == 7)

      puts 'Promote pawn to (Q, R, B, N):'
      choice = gets.chomp.upcase
      new_piece = case choice
                  when 'Q' then Queen.new(piece.color, to)
                  when 'R' then Rook.new(piece.color, to)
                  when 'B' then Bishop.new(piece.color, to)
                  when 'N' then Knight.new(piece.color, to)
                  else Queen.new(piece.color, to)
                  end
      @board.place_piece(to, new_piece)
    end

    # castling validation and execution
    def handle_castling(input)
      side = input.split.last.downcase
      if @board.can_castle?(@current_player_color, side)
        @board.perform_castling(@current_player_color, side)
        puts "#{@current_player_color.capitalize} castled #{side == 'k' ? 'kingside' : 'queenside'}."
      else
        puts 'Castling not allowed.'
      end
    end

    def opponent_color
      @current_player_color == :white ? :black : :white
    end
  end
end
